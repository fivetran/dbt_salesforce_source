{% macro get_contact_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "department", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "email", "datatype": dbt_utils.type_string()},
    {"name": "first_name", "datatype": dbt_utils.type_string()},
    {"name": "home_phone", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "individual_id", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "last_activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_modified_by_id", "datatype": dbt_utils.type_string()},
    {"name": "last_modified_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_name", "datatype": dbt_utils.type_string()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "lead_source", "datatype": dbt_utils.type_string()},
    {"name": "mailing_city", "datatype": dbt_utils.type_string()},
    {"name": "mailing_country", "datatype": dbt_utils.type_string()},
    {"name": "mailing_country_code", "datatype": dbt_utils.type_string()},
    {"name": "mailing_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "mailing_state", "datatype": dbt_utils.type_string()},
    {"name": "mailing_state_code", "datatype": dbt_utils.type_string()},
    {"name": "mailing_street", "datatype": dbt_utils.type_string()},
    {"name": "master_record_id", "datatype": dbt_utils.type_string()},
    {"name": "mobile_phone", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "owner_id", "datatype": dbt_utils.type_string()},
    {"name": "phone", "datatype": dbt_utils.type_string()},
    {"name": "reports_to_id", "datatype": dbt_utils.type_string()},
    {"name": "title", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}
