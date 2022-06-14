{% macro get_contact_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "assistant_name", "datatype": dbt_utils.type_string()},
    {"name": "assistant_phone", "datatype": dbt_utils.type_string()},
    {"name": "birthdate", "datatype": dbt_utils.type_timestamp()},
    {"name": "department", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "do_not_call", "datatype": "boolean"},
    {"name": "email", "datatype": dbt_utils.type_string()},
    {"name": "email_bounced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "email_bounced_reason", "datatype": dbt_utils.type_string()},
    {"name": "fax", "datatype": dbt_utils.type_string()},
    {"name": "first_name", "datatype": dbt_utils.type_string()},
    {"name": "has_opted_out_of_email", "datatype": "boolean"},
    {"name": "has_opted_out_of_fax", "datatype": "boolean"},
    {"name": "home_phone", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "individual_id", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "is_email_bounced", "datatype": "boolean"},
    {"name": "jigsaw", "datatype": dbt_utils.type_string()},
    {"name": "jigsaw_contact_id", "datatype": dbt_utils.type_string()},
    {"name": "last_activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_curequest_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_cuupdate_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_modified_by_id", "datatype": dbt_utils.type_string()},
    {"name": "last_modified_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_name", "datatype": dbt_utils.type_string()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "lead_source", "datatype": dbt_utils.type_string()},
    {"name": "mailing_city", "datatype": dbt_utils.type_string()},
    {"name": "mailing_country", "datatype": dbt_utils.type_string()},
    {"name": "mailing_country_code", "datatype": dbt_utils.type_string()},
    {"name": "mailing_geocode_accuracy", "datatype": dbt_utils.type_string()},
    {"name": "mailing_latitude", "datatype": dbt_utils.type_float()},
    {"name": "mailing_longitude", "datatype": dbt_utils.type_float()},
    {"name": "mailing_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "mailing_state", "datatype": dbt_utils.type_string()},
    {"name": "mailing_state_code", "datatype": dbt_utils.type_string()},
    {"name": "mailing_street", "datatype": dbt_utils.type_string()},
    {"name": "master_record_id", "datatype": dbt_utils.type_string()},
    {"name": "mobile_phone", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "other_city", "datatype": dbt_utils.type_string()},
    {"name": "other_country", "datatype": dbt_utils.type_string()},
    {"name": "other_geocode_accuracy", "datatype": dbt_utils.type_string()},
    {"name": "other_latitude", "datatype": dbt_utils.type_float()},
    {"name": "other_longitude", "datatype": dbt_utils.type_float()},
    {"name": "other_phone", "datatype": dbt_utils.type_string()},
    {"name": "other_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "other_state", "datatype": dbt_utils.type_string()},
    {"name": "other_street", "datatype": dbt_utils.type_string()},
    {"name": "owner_id", "datatype": dbt_utils.type_string()},
    {"name": "phone", "datatype": dbt_utils.type_string()},
    {"name": "photo_url", "datatype": dbt_utils.type_string()},
    {"name": "reports_to_id", "datatype": dbt_utils.type_string()},
    {"name": "salutation", "datatype": dbt_utils.type_string()},
    {"name": "system_modstamp", "datatype": dbt_utils.type_timestamp()},
    {"name": "title", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}