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
        {{ coalesce_w_renamed_col('account_id') }},
        {{ coalesce_w_renamed_col('activity_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('call_disposition') }},
        {{ coalesce_w_renamed_col('call_duration_in_seconds') }},
        {{ coalesce_w_renamed_col('call_object') }},
        {{ coalesce_w_renamed_col('call_type') }},
        {{ coalesce_w_renamed_col('completed_date_time', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('created_by_id') }},
        {{ coalesce_w_renamed_col('created_date', datatype=dbt.type_timestamp()) }},
        description as task_description,
        {{ coalesce_w_renamed_col('is_archived') }},
        {{ coalesce_w_renamed_col('is_closed') }},
        {{ coalesce_w_renamed_col('is_deleted') }},
        {{ coalesce_w_renamed_col('is_high_priority') }},
        {{ coalesce_w_renamed_col('last_modified_by_id') }},
        {{ coalesce_w_renamed_col('last_modified_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('owner_id') }},
        priority,
        {{ coalesce_w_renamed_col('record_type_id') }},
        status,
        subject,
        {{ coalesce_w_renamed_col('task_subtype') }},
        type,
        {{ coalesce_w_renamed_col('what_count') }},
        {{ coalesce_w_renamed_col('what_id') }},
        {{ coalesce_w_renamed_col('who_count') }},
        {{ coalesce_w_renamed_col('who_id') }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__task_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)