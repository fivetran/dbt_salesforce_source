
with base as (

    select * 
    from {{ ref('stg_salesforce__task_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__task_tmp')),
                staging_columns=get_task_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        account_id,
        activity_date,
        call_disposition,
        call_duration_in_seconds,
        call_object,
        call_type,
        completed_date_time,
        created_by_id,
        created_date,
        description,
        id,
        is_archived,
        is_closed,
        is_deleted,
        is_high_priority,
        last_modified_by_id,
        last_modified_date,
        owner_id,
        priority,
        record_type_id,
        reminder_date_time,
        status,
        subject,
        task_subtype,
        type,
        what_count,
        what_id,
        who_count,
        who_id
    from fields
)

select *
from final
