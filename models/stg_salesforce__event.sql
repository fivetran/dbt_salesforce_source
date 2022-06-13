
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
        duration_in_minutes,
        end_date,
        end_date_time,
        event_subtype,
        group_event_type,
        id,
        is_archived,
        is_child,
        is_deleted,
        is_group_event,
        is_private,
        is_recurrence,
        is_recurrence_2,
        is_recurrence_2_exception,
        is_recurrence_2_exclusion,
        is_reminder_set,
        last_modified_by_id,
        last_modified_date,
        location,
        owner_id,
        recurrence_2_pattern_start_date,
        recurrence_2_pattern_text,
        recurrence_2_pattern_time_zone,
        recurrence_2_pattern_version,
        recurrence_activity_id,
        recurrence_day_of_month,
        recurrence_day_of_week_mask,
        recurrence_end_date_only,
        recurrence_instance,
        recurrence_interval,
        recurrence_month_of_year,
        recurrence_start_date_time,
        recurrence_time_zone_sid_key,
        recurrence_type,
        reminder_date_time,
        show_as,
        start_date_time,
        subject,
        system_modstamp,
        type,
        what_count,
        what_id,
        who_count,
        who_id
    from fields
)

select *
from final
