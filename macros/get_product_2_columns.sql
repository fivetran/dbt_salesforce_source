{% macro get_product_2_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "created_by_id", "datatype": dbt_utils.type_string()},
    {"name": "created_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "display_url", "datatype": dbt_utils.type_string()},
    {"name": "external_id", "datatype": dbt_utils.type_string()},
    {"name": "family", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_active", "datatype": "boolean"},
    {"name": "is_archived", "datatype": "boolean"},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "last_modified_by_id", "datatype": dbt_utils.type_string()},
    {"name": "last_modified_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "number_of_quantity_installments", "datatype": dbt_utils.type_int()},
    {"name": "number_of_revenue_installments", "datatype": dbt_utils.type_int()},
    {"name": "product_code", "datatype": dbt_utils.type_string()},
    {"name": "quantity_installment_period", "datatype": dbt_utils.type_string()},
    {"name": "quantity_schedule_type", "datatype": dbt_utils.type_string()},
    {"name": "quantity_unit_of_measure", "datatype": dbt_utils.type_string()},
    {"name": "record_type_id", "datatype": dbt_utils.type_string()},
    {"name": "revenue_installment_period", "datatype": dbt_utils.type_string()},
    {"name": "revenue_schedule_type", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}
