--To disable this model, set the salesforce__task_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__task_enabled', True)) }}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','task')),
                staging_columns=get_task_columns()
            )
        }}
        
    from {{ source('salesforce','task') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        id as task_id,
        account_id,
        cast(activity_date as {{ dbt.type_timestamp() }}) as activity_date,
        call_disposition,
        call_duration_in_seconds,
        call_object,
        call_type,
        cast(completed_date_time as {{ dbt.type_timestamp() }}) as completed_date_time,
        created_by_id,
        cast(created_date as {{ dbt.type_timestamp() }}) as created_date,
        description as task_description,
        is_archived,
        is_closed,
        is_deleted,
        is_high_priority,
        last_modified_by_id,
        cast(last_modified_date as {{ dbt.type_timestamp() }}) as last_modified_date,
        owner_id,
        priority,
        record_type_id,
        status,
        subject,
        task_subtype,
        type,
        what_count,
        what_id,
        who_count,
        who_id
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__task_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)