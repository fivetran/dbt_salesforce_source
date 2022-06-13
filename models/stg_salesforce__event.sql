
with base as (

    select * 
    from {{ ref('stg_salesforce__event_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__event_tmp')),
                staging_columns=get_event_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        account_id,
        activity_date,
        activity_date_time,
        created_by_id,
        created_date,
        description,
        end_date,
        end_date_time,
        event_subtype,
        group_event_type,
        id,
        is_archived,
        is_child,
        is_deleted,
        is_group_event,
        is_recurrence,
        last_modified_by_id,
        last_modified_date,
        location,
        owner_id,
        start_date_time,
        subject,
        type,
        what_count,
        what_id,
        who_count,
        who_id
    from fields
)

select *
from final
