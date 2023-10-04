{{ config(enabled=var('salesforce__opportunity_history_enabled', False)) }}

with base as (

    select *
    from {{ ref('stg_salesforce__opportunity_history_tmp') }}
), 

fields as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__opportunity_history_tmp')),
                staging_columns=get_opportunity_history_columns()
            )
        }}

    from base
), 

final as (
    
    select 
        id as opportunity_id,
        _fivetran_active,        
        cast(_fivetran_start as {{ dbt.type_timestamp() }}) as _fivetran_start,
        cast(_fivetran_end as {{ dbt.type_timestamp() }}) as _fivetran_end,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        account_id,
        cast(amount as {{ dbt.type_numeric() }}) as amount,
        campaign_id,
        cast(close_date as {{ dbt.type_timestamp() }}) as close_date,
        cast(created_date as {{ dbt.type_timestamp() }}) as created_date,
        description as opportunity_description,
        cast(expected_revenue as {{ dbt.type_numeric() }}) as expected_revenue,
        fiscal,
        fiscal_quarter,
        fiscal_year,
        forecast_category,
        forecast_category_name,
        has_open_activity,
        has_opportunity_line_item,
        has_overdue_task,
        is_closed,
        is_deleted,
        is_won,
        cast(last_activity_date as {{ dbt.type_timestamp() }}) as last_activity_date,
        cast(last_referenced_date as {{ dbt.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt.type_timestamp() }}) as last_viewed_date,
        lead_source,
        name as opportunity_name,
        next_step,
        owner_id,
        probability,
        record_type_id,
        stage_name,
        synced_quote_id,
        type
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__opportunity_history_pass_through_columns') }}

    from fields
)

select *
from final
where not coalesce(is_deleted, false)