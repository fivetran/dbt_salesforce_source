--To disable this model, set the salesforce__event_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__event_enabled', True)) }}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','event')),
                staging_columns=get_event_columns()
            )
        }}

    from {{ source('salesforce','event') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        id as event_id,
        {{ coalesce_w_renamed_col('account_id') }},
        {{ coalesce_w_renamed_col('activity_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('activity_date_time', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('created_by_id') }},
        {{ coalesce_w_renamed_col('created_date', datatype=dbt.type_timestamp()) }},
        description as event_description,
        {{ coalesce_w_renamed_col('end_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('end_date_time', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('event_subtype') }},
        {{ coalesce_w_renamed_col('group_event_type') }},
        {{ coalesce_w_renamed_col('is_archived') }},
        {{ coalesce_w_renamed_col('is_child') }},
        {{ coalesce_w_renamed_col('is_deleted') }},
        {{ coalesce_w_renamed_col('is_group_event') }},
        {{ coalesce_w_renamed_col('is_recurrence') }},
        {{ coalesce_w_renamed_col('last_modified_by_id') }},
        {{ coalesce_w_renamed_col('last_modified_date', datatype=dbt.type_timestamp()) }},
        location,
        {{ coalesce_w_renamed_col('owner_id') }},
        {{ coalesce_w_renamed_col('start_date_time', datatype=dbt.type_timestamp()) }},
        subject,
        type,
        {{ coalesce_w_renamed_col('what_count') }},
        {{ coalesce_w_renamed_col('what_id') }},
        {{ coalesce_w_renamed_col('who_count') }},
        {{ coalesce_w_renamed_col('who_id') }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__event_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)
