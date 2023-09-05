{% macro get_user_role_history_columns() %}

{% set columns = [
    {"name": "_fivetran_active", "datatype": "boolean"},
    {"name": "_fivetran_end", "datatype": dbt.type_timestamp()},
    {"name": "_fivetran_start", "datatype": dbt.type_timestamp()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "case_access_for_account_owner", "datatype": dbt.type_string()},
    {"name": "contact_access_for_account_owner", "datatype": dbt.type_string()},
    {"name": "developer_name", "datatype": dbt.type_string()},
    {"name": "forecast_user_id", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_string()},
    {"name": "last_modified_by_id", "datatype": dbt.type_string()},
    {"name": "last_modified_date", "datatype": dbt.type_timestamp()},
    {"name": "may_forecast_manager_share", "datatype": "boolean"},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "opportunity_access_for_account_owner", "datatype": dbt.type_string()},
    {"name": "parent_role_id", "datatype": dbt.type_string()},
    {"name": "portal_account_id", "datatype": dbt.type_string()},
    {"name": "portal_account_owner_id", "datatype": dbt.type_string()},
    {"name": "portal_type", "datatype": dbt.type_string()},
    {"name": "rollup_description", "datatype": dbt.type_string()},
    {"name": "system_modstamp", "datatype": dbt.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}