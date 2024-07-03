{% set column_list = get_contact_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','contact')),
                staging_columns=column_list
            )
        }}
        
    from {{ source('salesforce','contact') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("id", column_dict, alias="contact_id") }},
        {{ coalesce_rename("account_id", column_dict) }},
        {{ coalesce_rename("department", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="contact_description") }},
        {{ coalesce_rename("email", column_dict) }},
        {{ coalesce_rename("first_name", column_dict) }},
        {{ coalesce_rename("home_phone", column_dict) }},
        {{ coalesce_rename("individual_id", column_dict) }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("last_activity_date", column_dict) }},
        {{ coalesce_rename("last_modified_by_id", column_dict) }},
        {{ coalesce_rename("last_modified_date", column_dict) }},
        {{ coalesce_rename("last_name", column_dict) }},
        {{ coalesce_rename("last_referenced_date", column_dict) }},
        {{ coalesce_rename("last_viewed_date", column_dict) }},
        {{ coalesce_rename("lead_source", column_dict) }},
        {{ coalesce_rename("mailing_city", column_dict) }},
        {{ coalesce_rename("mailing_country", column_dict) }},
        {{ coalesce_rename("mailing_country_code", column_dict) }},
        {{ coalesce_rename("mailing_postal_code", column_dict) }},
        {{ coalesce_rename("mailing_state", column_dict) }},
        {{ coalesce_rename("mailing_state_code", column_dict) }},
        {{ coalesce_rename("mailing_street", column_dict) }},
        {{ coalesce_rename("master_record_id", column_dict) }},
        {{ coalesce_rename("mobile_phone", column_dict) }},
        {{ coalesce_rename("name", column_dict, alias="contact_name") }},
        {{ coalesce_rename("owner_id", column_dict) }},
        {{ coalesce_rename("phone", column_dict) }},
        {{ coalesce_rename("reports_to_id", column_dict) }},
        {{ coalesce_rename("title", column_dict) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__contact_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)