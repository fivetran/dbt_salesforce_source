{% macro get_account_columns() %}

{% set columns = [

    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_number", "datatype": dbt_utils.type_string()},
    {"name": "account_source", "datatype": dbt_utils.type_string()},
    {"name": "annual_revenue", "datatype": dbt_utils.type_float()},
    {"name": "billing_city", "datatype": dbt_utils.type_string()},
    {"name": "billing_country", "datatype": dbt_utils.type_string()},
    {"name": "billing_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_state", "datatype": dbt_utils.type_string()},
    {"name": "billing_state_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_street", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "industry", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "last_activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "master_record_id", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "number_of_employees", "datatype": dbt_utils.type_int()},
    {"name": "owner_id", "datatype": dbt_utils.type_string()},
    {"name": "ownership", "datatype": dbt_utils.type_string()},
    {"name": "parent_id", "datatype": dbt_utils.type_string()},
    {"name": "rating", "datatype": dbt_utils.type_string()},
    {"name": "record_type_id", "datatype": dbt_utils.type_string()},
    {"name": "shipping_city", "datatype": dbt_utils.type_string()},
    {"name": "shipping_country", "datatype": dbt_utils.type_string()},
    {"name": "shipping_country_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_state", "datatype": dbt_utils.type_string()},
    {"name": "shipping_state_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_street", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "website", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}