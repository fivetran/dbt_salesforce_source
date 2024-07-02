{% macro get_user_role_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_active", "datatype": dbt.type_boolean(), "exclude_from_final": true},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "developer_name", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_string(), "alias": "user_role_id"},
    {"name": "name", "datatype": dbt.type_string(), "alias": "user_role_name"},
    {"name": "opportunity_access_for_account_owner", "datatype": dbt.type_string()},
    {"name": "parent_role_id", "datatype": dbt.type_string()},
    {"name": "rollup_description", "datatype": dbt.type_string()}
] %}

{{ salesforce_source.add_renamed_columns(columns) }}

{{ fivetran_utils.add_pass_through_columns(columns, var('salesforce__user_role_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}