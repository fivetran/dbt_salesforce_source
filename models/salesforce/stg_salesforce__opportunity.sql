{% set column_list = get_opportunity_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','opportunity')),
                staging_columns=column_list
            )
        }}

    from {{ source('salesforce','opportunity') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("account_id", column_dict) }},
        {{ coalesce_rename("amount", column_dict, datatype=dbt.type_numeric()) }},
        {{ coalesce_rename("campaign_id", column_dict) }},
        {{ coalesce_rename("close_date", column_dict) }},
        {{ coalesce_rename("created_date", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="opportunity_description") }},
        {{ coalesce_rename("expected_revenue", column_dict) }},
        {{ coalesce_rename("fiscal", column_dict) }},
        {{ coalesce_rename("fiscal_quarter", column_dict) }},
        {{ coalesce_rename("fiscal_year", column_dict) }},
        {{ coalesce_rename("forecast_category", column_dict) }},
        {{ coalesce_rename("forecast_category_name", column_dict) }},
        {{ coalesce_rename("has_open_activity", column_dict) }},
        {{ coalesce_rename("has_opportunity_line_item", column_dict) }},
        {{ coalesce_rename("has_overdue_task", column_dict) }},
        {{ coalesce_rename("id", column_dict, alias="opportunity_id") }},
        {{ coalesce_rename("is_closed", column_dict) }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("is_won", column_dict) }},
        {{ coalesce_rename("last_activity_date", column_dict) }},
        {{ coalesce_rename("last_referenced_date", column_dict) }},
        {{ coalesce_rename("last_viewed_date", column_dict) }},
        {{ coalesce_rename("lead_source", column_dict) }},
        {{ coalesce_rename("name", column_dict, alias="opportunity_name") }},
        {{ coalesce_rename("next_step", column_dict) }},
        {{ coalesce_rename("owner_id", column_dict) }},
        {{ coalesce_rename("probability", column_dict) }},
        {{ coalesce_rename("record_type_id", column_dict) }},
        {{ coalesce_rename("stage_name", column_dict) }},
        {{ coalesce_rename("synced_quote_id", column_dict) }},
        {{ coalesce_rename("type", column_dict) }}
        
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