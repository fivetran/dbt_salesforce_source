--To disable this model, set the salesforce__lead_enabled within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__lead_enabled', True)) }}

{% set column_list = get_lead_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','lead')),
                staging_columns=column_list
            )
        }}
        
    from {{ source('salesforce','lead') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("id", column_dict, alias="lead_id") }},
        {{ coalesce_rename("annual_revenue", column_dict) }},
        {{ coalesce_rename("city", column_dict) }},
        {{ coalesce_rename("company", column_dict) }},
        {{ coalesce_rename("converted_account_id", column_dict) }},
        {{ coalesce_rename("converted_contact_id", column_dict) }},
        {{ coalesce_rename("converted_date", column_dict) }},
        {{ coalesce_rename("converted_opportunity_id", column_dict) }},
        {{ coalesce_rename("country", column_dict) }},
        {{ coalesce_rename("country_code", column_dict) }},
        {{ coalesce_rename("created_by_id", column_dict) }},
        {{ coalesce_rename("created_date", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="lead_description") }},
        {{ coalesce_rename("email", column_dict) }},
        {{ coalesce_rename("email_bounced_date", column_dict) }},
        {{ coalesce_rename("email_bounced_reason", column_dict) }},
        {{ coalesce_rename("first_name", column_dict) }},
        {{ coalesce_rename("has_opted_out_of_email", column_dict) }},
        {{ coalesce_rename("individual_id", column_dict) }},
        {{ coalesce_rename("industry", column_dict) }},
        {{ coalesce_rename("is_converted", column_dict) }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("is_unread_by_owner", column_dict) }},
        {{ coalesce_rename("last_activity_date", column_dict) }},
        {{ coalesce_rename("last_modified_by_id", column_dict) }},
        {{ coalesce_rename("last_modified_date", column_dict) }},
        {{ coalesce_rename("last_name", column_dict) }},
        {{ coalesce_rename("last_referenced_date", column_dict) }},
        {{ coalesce_rename("last_viewed_date", column_dict) }},
        {{ coalesce_rename("lead_source", column_dict) }},
        {{ coalesce_rename("master_record_id", column_dict) }},
        {{ coalesce_rename("mobile_phone", column_dict) }},
        {{ coalesce_rename("name", column_dict, alias="lead_name") }},
        {{ coalesce_rename("number_of_employees", column_dict) }},
        {{ coalesce_rename("owner_id", column_dict) }},
        {{ coalesce_rename("phone", column_dict) }},
        {{ coalesce_rename("postal_code", column_dict) }},
        {{ coalesce_rename("state", column_dict) }},
        {{ coalesce_rename("state_code", column_dict) }},
        {{ coalesce_rename("status", column_dict) }},
        {{ coalesce_rename("street", column_dict) }},
        {{ coalesce_rename("title", column_dict) }},
        {{ coalesce_rename("website", column_dict) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__lead_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)