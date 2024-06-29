with fields as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','opportunity')),
                staging_columns=get_opportunity_columns()
            )
        }}

    from {{ source('salesforce','opportunity') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_w_renamed_col('account_id') }},
        cast(amount as {{ dbt.type_numeric() }}) as amount,
        {{ coalesce_w_renamed_col('campaign_id') }},
        {{ coalesce_w_renamed_col('close_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('created_date', datatype=dbt.type_timestamp()) }},
        description as opportunity_description,
        {{ coalesce_w_renamed_col('expected_revenue', datatype=dbt.type_numeric()) }},
        fiscal,
        {{ coalesce_w_renamed_col('fiscal_quarter') }},
        {{ coalesce_w_renamed_col('fiscal_year') }},
        {{ coalesce_w_renamed_col('forecast_category') }},
        {{ coalesce_w_renamed_col('forecast_category_name') }},
        {{ coalesce_w_renamed_col('has_open_activity') }},
        {{ coalesce_w_renamed_col('has_opportunity_line_item') }},
        {{ coalesce_w_renamed_col('has_overdue_task') }},
        id as opportunity_id,
        {{ coalesce_w_renamed_col('is_closed') }},
        {{ coalesce_w_renamed_col('is_deleted') }},
        {{ coalesce_w_renamed_col('is_won') }},
        {{ coalesce_w_renamed_col('last_activity_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_referenced_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_viewed_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('lead_source') }},
        name as opportunity_name,
        {{ coalesce_w_renamed_col('next_step') }},
        {{ coalesce_w_renamed_col('owner_id') }},
        probability,
        {{ coalesce_w_renamed_col('record_type_id') }},
        {{ coalesce_w_renamed_col('stage_name') }},
        {{ coalesce_w_renamed_col('synced_quote_id') }},
        type
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__opportunity_pass_through_columns') }}

    from fields
    where coalesce(_fivetran_active, true)
), 

calculated as (
        
    select 
        *,
        created_date >= {{ dbt.date_trunc('month', dbt.current_timestamp_backcompat()) }} as is_created_this_month,
        created_date >= {{ dbt.date_trunc('quarter', dbt.current_timestamp_backcompat()) }} as is_created_this_quarter,
        {{ dbt.datediff(dbt.current_timestamp_backcompat(), 'created_date', 'day') }} as days_since_created,
        {{ dbt.datediff('close_date', 'created_date', 'day') }} as days_to_close,
        {{ dbt.date_trunc('month', 'close_date') }} = {{ dbt.date_trunc('month', dbt.current_timestamp_backcompat()) }} as is_closed_this_month,
        {{ dbt.date_trunc('quarter', 'close_date') }} = {{ dbt.date_trunc('quarter', dbt.current_timestamp_backcompat()) }} as is_closed_this_quarter
    from final
)

select * 
from calculated
where not coalesce(is_deleted, false)