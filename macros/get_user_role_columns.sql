{% macro get_user_role_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "developer_name", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "opportunity_access_for_account_owner", "datatype": dbt_utils.type_string()},
    {"name": "parent_role_id", "datatype": dbt_utils.type_string()},
    {"name": "rollup_description", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}