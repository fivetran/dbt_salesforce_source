
{% macro get_opportunity_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "amount", "datatype": dbt_utils.type_float()},
    {"name": "campaign_id", "datatype": dbt_utils.type_string()},
    {"name": "close_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "created_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "expected_revenue", "datatype": dbt_utils.type_numeric()},
    {"name": "fiscal", "datatype": dbt_utils.type_string()},
    {"name": "fiscal_quarter", "datatype": dbt_utils.type_int()},
    {"name": "fiscal_year", "datatype": dbt_utils.type_int()},
    {"name": "forecast_category", "datatype": dbt_utils.type_string()},
    {"name": "forecast_category_name", "datatype": dbt_utils.type_string()},
    {"name": "has_open_activity", "datatype": "boolean"},
    {"name": "has_opportunity_line_item", "datatype": "boolean"},
    {"name": "has_overdue_task", "datatype": "boolean"},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_closed", "datatype": "boolean"},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "is_won", "datatype": "boolean"},
    {"name": "last_activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "lead_source", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "next_step", "datatype": dbt_utils.type_string()},
    {"name": "owner_id", "datatype": dbt_utils.type_string()},
    {"name": "probability", "datatype": dbt_utils.type_float()},
    {"name": "record_type_id", "datatype": dbt_utils.type_string()},
    {"name": "stage_name", "datatype": dbt_utils.type_string()},
    {"name": "synced_quote_id", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}