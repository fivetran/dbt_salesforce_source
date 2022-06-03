{% macro get_user_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "alias", "datatype": dbt_utils.type_string()},
    {"name": "city", "datatype": dbt_utils.type_string()},
    {"name": "company_name", "datatype": dbt_utils.type_string()},
    {"name": "contact_id", "datatype": dbt_utils.type_string()},
    {"name": "country", "datatype": dbt_utils.type_string()},
    {"name": "country_code", "datatype": dbt_utils.type_string()},
    {"name": "department", "datatype": dbt_utils.type_string()},
    {"name": "email", "datatype": dbt_utils.type_string()},
    {"name": "first_name", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "individual_id", "datatype": dbt_utils.type_string()},
    {"name": "is_active", "datatype": "boolean"},
    {"name": "last_login_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_name", "datatype": dbt_utils.type_string()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "manager_id", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "postal_code", "datatype": dbt_utils.type_string()},
    {"name": "profile_id", "datatype": dbt_utils.type_string()},
    {"name": "state", "datatype": dbt_utils.type_string()},
    {"name": "state_code", "datatype": dbt_utils.type_string()},
    {"name": "street", "datatype": dbt_utils.type_string()},
    {"name": "title", "datatype": dbt_utils.type_string()},
    {"name": "user_role_id", "datatype": dbt_utils.type_string()},
    {"name": "user_type", "datatype": dbt_utils.type_string()},
    {"name": "username", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}