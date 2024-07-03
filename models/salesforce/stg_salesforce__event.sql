--To disable this model, set the salesforce__event_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__event_enabled', True)) }}

{% set column_list = get_event_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','event')),
                staging_columns=column_list
            )
        }}

    from {{ source('salesforce','event') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("id", column_dict, alias="event_id") }},
        {{ coalesce_rename("account_id", column_dict) }},
        {{ coalesce_rename("activity_date", column_dict) }},
        {{ coalesce_rename("activity_date_time", column_dict) }},
        {{ coalesce_rename("created_by_id", column_dict) }},
        {{ coalesce_rename("created_date", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="event_description") }},
        {{ coalesce_rename("end_date", column_dict) }},
        {{ coalesce_rename("end_date_time", column_dict) }},
        {{ coalesce_rename("event_subtype", column_dict) }},
        {{ coalesce_rename("group_event_type", column_dict) }},
        {{ coalesce_rename("is_archived", column_dict) }},
        {{ coalesce_rename("is_child", column_dict) }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("is_group_event", column_dict) }},
        {{ coalesce_rename("is_recurrence", column_dict) }},
        {{ coalesce_rename("last_modified_by_id", column_dict) }},
        {{ coalesce_rename("last_modified_date", column_dict) }},
        {{ coalesce_rename("location", column_dict) }},
        {{ coalesce_rename("owner_id", column_dict) }},
        {{ coalesce_rename("start_date_time", column_dict) }},
        {{ coalesce_rename("subject", column_dict) }},
        {{ coalesce_rename("type", column_dict) }},
        {{ coalesce_rename("what_count", column_dict) }},
        {{ coalesce_rename("what_id", column_dict) }},
        {{ coalesce_rename("who_count", column_dict) }},
        {{ coalesce_rename("who_id", column_dict) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__event_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)
