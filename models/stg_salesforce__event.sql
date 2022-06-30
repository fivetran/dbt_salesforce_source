--To disable this model, set the using_user_role variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__event_enabled', True)) }}

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

        --The below script allows for pass through columns.
        {% if var('event_pass_through_columns',[]) != [] %}
        , {{ var('event_pass_through_columns') | join (", ")}}
        {% endif %}
        
    from base
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt_utils.type_timestamp() }}) as _fivetran_synced,
        id as event_id,
        account_id,
        cast(activity_date as {{ dbt_utils.type_timestamp() }}) as activity_date,
        cast(activity_date_time as {{ dbt_utils.type_timestamp() }}) as activity_date_time,
        created_by_id,
        cast(created_date as {{ dbt_utils.type_timestamp() }}) as created_date,
        description as event_description,
        cast(end_date as {{ dbt_utils.type_timestamp() }}) as end_date,
        cast(end_date_time as {{ dbt_utils.type_timestamp() }}) as end_date_time,
        event_subtype,
        group_event_type,
        is_archived,
        is_child,
        is_deleted,
        is_group_event,
        is_recurrence,
        last_modified_by_id,
        cast(last_modified_date as {{ dbt_utils.type_timestamp() }}) as last_modified_date,
        location,
        owner_id,
        cast(start_date_time as {{ dbt_utils.type_timestamp() }}) as start_date_time,
        subject,
        type,
        what_count,
        what_id,
        who_count,
        who_id

        --The below script allows for pass through columns.
        {% if var('event_pass_through_columns',[]) != [] %}
        , {{ var('event_pass_through_columns') | join (", ")}}

        {% endif %}
        
    from fields
)

select *
from final
where not coalesce(is_deleted, false)
