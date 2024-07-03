--To disable this model, set the salesforce__task_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__task_enabled', True)) }}

{% set column_list = get_task_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','task')),
                staging_columns=column_list
            )
        }}
        
    from {{ source('salesforce','task') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("id", column_dict, alias="task_id") }},
        {{ coalesce_rename("account_id", column_dict) }},
        {{ coalesce_rename("activity_date", column_dict) }},
        {{ coalesce_rename("call_disposition", column_dict) }},
        {{ coalesce_rename("call_duration_in_seconds", column_dict) }},
        {{ coalesce_rename("call_object", column_dict) }},
        {{ coalesce_rename("call_type", column_dict) }},
        {{ coalesce_rename("completed_date_time", column_dict) }},
        {{ coalesce_rename("created_by_id", column_dict) }},
        {{ coalesce_rename("created_date", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="task_description") }},
        {{ coalesce_rename("is_archived", column_dict) }},
        {{ coalesce_rename("is_closed", column_dict) }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("is_high_priority", column_dict) }},
        {{ coalesce_rename("last_modified_by_id", column_dict) }},
        {{ coalesce_rename("last_modified_date", column_dict) }},
        {{ coalesce_rename("owner_id", column_dict) }},
        {{ coalesce_rename("priority", column_dict) }},
        {{ coalesce_rename("record_type_id", column_dict) }},
        {{ coalesce_rename("status", column_dict) }},
        {{ coalesce_rename("subject", column_dict) }},
        {{ coalesce_rename("task_subtype", column_dict) }},
        {{ coalesce_rename("type", column_dict) }},
        {{ coalesce_rename("what_count", column_dict) }},
        {{ coalesce_rename("what_id", column_dict) }},
        {{ coalesce_rename("who_count", column_dict) }},
        {{ coalesce_rename("who_id", column_dict) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__task_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)