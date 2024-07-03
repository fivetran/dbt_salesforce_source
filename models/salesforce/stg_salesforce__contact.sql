{% set contact_column_list = get_contact_columns() -%}
{% set contact_dict = column_list_to_dict(contact_column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','contact')),
                staging_columns=contact_column_list
            )
        }}
        
    from {{ source('salesforce','contact') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("id", contact_dict, alias="contact_id") }},
        {{ coalesce_rename("account_id", contact_dict) }},
        {{ coalesce_rename("department", contact_dict) }},
        {{ coalesce_rename("description", contact_dict, alias="contact_description") }},
        {{ coalesce_rename("email", contact_dict) }},
        {{ coalesce_rename("first_name", contact_dict) }},
        {{ coalesce_rename("home_phone", contact_dict) }},
        {{ coalesce_rename("individual_id", contact_dict) }},
        {{ coalesce_rename("is_deleted", contact_dict) }},
        {{ coalesce_rename("last_activity_date", contact_dict) }},
        {{ coalesce_rename("last_modified_by_id", contact_dict) }},
        {{ coalesce_rename("last_modified_date", contact_dict) }},
        {{ coalesce_rename("last_name", contact_dict) }},
        {{ coalesce_rename("last_referenced_date", contact_dict) }},
        {{ coalesce_rename("last_viewed_date", contact_dict) }},
        {{ coalesce_rename("lead_source", contact_dict) }},
        {{ coalesce_rename("mailing_city", contact_dict) }},
        {{ coalesce_rename("mailing_country", contact_dict) }},
        {{ coalesce_rename("mailing_country_code", contact_dict) }},
        {{ coalesce_rename("mailing_postal_code", contact_dict) }},
        {{ coalesce_rename("mailing_state", contact_dict) }},
        {{ coalesce_rename("mailing_state_code", contact_dict) }},
        {{ coalesce_rename("mailing_street", contact_dict) }},
        {{ coalesce_rename("master_record_id", contact_dict) }},
        {{ coalesce_rename("mobile_phone", contact_dict) }},
        {{ coalesce_rename("name", contact_dict, alias="contact_name") }},
        {{ coalesce_rename("owner_id", contact_dict) }},
        {{ coalesce_rename("phone", contact_dict) }},
        {{ coalesce_rename("reports_to_id", contact_dict) }},
        {{ coalesce_rename("title", contact_dict) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__contact_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)