{% macro get_user_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_active", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "account_id", "datatype": dbt.type_string()},
    {"name": "accountid", "datatype": dbt.type_string()},
    {"name": "alias", "datatype": dbt.type_string()},
    {"name": "city", "datatype": dbt.type_string()},
    {"name": "company_name", "datatype": dbt.type_string()},
    {"name": "companyname", "datatype": dbt.type_string()},
    {"name": "contact_id", "datatype": dbt.type_string()},
    {"name": "contactid", "datatype": dbt.type_string()},
    {"name": "country", "datatype": dbt.type_string()},
    {"name": "country_code", "datatype": dbt.type_string()},
    {"name": "countrycode", "datatype": dbt.type_string()},
    {"name": "department", "datatype": dbt.type_string()},
    {"name": "email", "datatype": dbt.type_string()},
    {"name": "first_name", "datatype": dbt.type_string()},
    {"name": "firstname", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_string()},
    {"name": "individual_id", "datatype": dbt.type_string()},
    {"name": "individualid", "datatype": dbt.type_string()},
    {"name": "is_active", "datatype": "boolean"},
    {"name": "isactive", "datatype": "boolean"},
    {"name": "last_login_date", "datatype": dbt.type_timestamp()},
    {"name": "lastlogindate", "datatype": dbt.type_timestamp()},
    {"name": "last_name", "datatype": dbt.type_string()},
    {"name": "lastname", "datatype": dbt.type_string()},
    {"name": "last_referenced_date", "datatype": dbt.type_timestamp()},
    {"name": "lastreferenceddate", "datatype": dbt.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt.type_timestamp()},
    {"name": "lastvieweddate", "datatype": dbt.type_timestamp()},
    {"name": "manager_id", "datatype": dbt.type_string()},
    {"name": "managerid", "datatype": dbt.type_string()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "postal_code", "datatype": dbt.type_string()},
    {"name": "postalcode", "datatype": dbt.type_string()},
    {"name": "profile_id", "datatype": dbt.type_string()},
    {"name": "profileid", "datatype": dbt.type_string()},
    {"name": "state", "datatype": dbt.type_string()},
    {"name": "state_code", "datatype": dbt.type_string()},
    {"name": "statecode", "datatype": dbt.type_string()},
    {"name": "street", "datatype": dbt.type_string()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "user_role_id", "datatype": dbt.type_string()},
    {"name": "userroleid", "datatype": dbt.type_string()},
    {"name": "user_type", "datatype": dbt.type_string()},
    {"name": "usertype", "datatype": dbt.type_string()},
    {"name": "username", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('salesforce__user_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}