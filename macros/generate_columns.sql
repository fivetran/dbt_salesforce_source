{% macro get_account_columns() %}

{% set columns = [

    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_number", "datatype": dbt_utils.type_string()},
    {"name": "account_source", "datatype": dbt_utils.type_string()},
    {"name": "annual_revenue", "datatype": dbt_utils.type_float()},
    {"name": "billing_city", "datatype": dbt_utils.type_string()},
    {"name": "billing_country", "datatype": dbt_utils.type_string()},
    {"name": "billing_country_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_geocode_accuracy", "datatype": dbt_utils.type_string()},
    {"name": "billing_latitude", "datatype": dbt_utils.type_float()},
    {"name": "billing_longitude", "datatype": dbt_utils.type_float()},
    {"name": "billing_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_state", "datatype": dbt_utils.type_string()},
    {"name": "billing_state_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_street", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "fax", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "account_id"},
    {"name": "industry", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "jigsaw_company_id", "datatype": dbt_utils.type_string()},
    {"name": "last_activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "master_record_id", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string(), "alias": "account_name"},
    {"name": "number_of_employees", "datatype": dbt_utils.type_int()},
    {"name": "owner_id", "datatype": dbt_utils.type_string()},
    {"name": "ownership", "datatype": dbt_utils.type_string()},
    {"name": "parent_id", "datatype": dbt_utils.type_string()},
    {"name": "phone", "datatype": dbt_utils.type_string()},
    {"name": "photo_url", "datatype": dbt_utils.type_string()},
    {"name": "rating", "datatype": dbt_utils.type_string()},
    {"name": "record_type_id", "datatype": dbt_utils.type_string()},
    {"name": "shipping_city", "datatype": dbt_utils.type_string()},
    {"name": "shipping_country", "datatype": dbt_utils.type_string()},
    {"name": "shipping_country_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_geocode_accuracy", "datatype": dbt_utils.type_string()},
    {"name": "shipping_latitude", "datatype": dbt_utils.type_float()},
    {"name": "shipping_longitude", "datatype": dbt_utils.type_float()},
    {"name": "shipping_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_state", "datatype": dbt_utils.type_string()},
    {"name": "shipping_state_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_street", "datatype": dbt_utils.type_string()},
    {"name": "sic", "datatype": dbt_utils.type_string()},
    {"name": "sic_desc", "datatype": dbt_utils.type_string()},
    {"name": "site", "datatype": dbt_utils.type_string()},
    {"name": "ticker_symbol", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "website", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}


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
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "opportunity_id"},
    {"name": "is_closed", "datatype": "boolean"},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "is_excluded_from_territory_2_filter", "datatype": "boolean"},
    {"name": "is_won", "datatype": "boolean"},
    {"name": "last_activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "lead_source", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string(), "alias": "opportunity_name"},
    {"name": "next_step", "datatype": dbt_utils.type_string()},
    {"name": "owner_id", "datatype": dbt_utils.type_string()},
    {"name": "pricebook_2_id", "datatype": dbt_utils.type_string()},
    {"name": "probability", "datatype": dbt_utils.type_float()},
    {"name": "record_type_id", "datatype": dbt_utils.type_string()},
    {"name": "stage_name", "datatype": dbt_utils.type_string()},
    {"name": "synced_quote_id", "datatype": dbt_utils.type_string()},
    {"name": "territory_2_id", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}


{% macro get_user_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "about_me", "datatype": dbt_utils.type_string()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "alias", "datatype": dbt_utils.type_string()},
    {"name": "badge_text", "datatype": dbt_utils.type_string()},
    {"name": "banner_photo_url", "datatype": dbt_utils.type_string()},
    {"name": "call_center_id", "datatype": dbt_utils.type_string()},
    {"name": "city", "datatype": dbt_utils.type_string()},
    {"name": "community_nickname", "datatype": dbt_utils.type_string()},
    {"name": "company_name", "datatype": dbt_utils.type_string()},
    {"name": "contact_id", "datatype": dbt_utils.type_string()},
    {"name": "country", "datatype": dbt_utils.type_string()},
    {"name": "country_code", "datatype": dbt_utils.type_string()},
    {"name": "default_group_notification_frequency", "datatype": dbt_utils.type_string()},
    {"name": "delegated_approver_id", "datatype": dbt_utils.type_string()},
    {"name": "department", "datatype": dbt_utils.type_string()},
    {"name": "digest_frequency", "datatype": dbt_utils.type_string()},
    {"name": "division", "datatype": dbt_utils.type_string()},
    {"name": "email", "datatype": dbt_utils.type_string()},
    {"name": "email_encoding_key", "datatype": dbt_utils.type_string()},
    {"name": "email_preferences_auto_bcc", "datatype": "boolean"},
    {"name": "employee_number", "datatype": dbt_utils.type_string()},
    {"name": "extension", "datatype": dbt_utils.type_string()},
    {"name": "fax", "datatype": dbt_utils.type_string()},
    {"name": "federation_identifier", "datatype": dbt_utils.type_string()},
    {"name": "first_name", "datatype": dbt_utils.type_string()},
    {"name": "forecast_enabled", "datatype": "boolean"},
    {"name": "full_photo_url", "datatype": dbt_utils.type_string()},
    {"name": "geocode_accuracy", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "user_id"},
    {"name": "individual_id", "datatype": dbt_utils.type_string()},
    {"name": "is_active", "datatype": "boolean"},
    {"name": "is_profile_photo_active", "datatype": "boolean"},
    {"name": "language_locale_key", "datatype": dbt_utils.type_string()},
    {"name": "last_login_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_name", "datatype": dbt_utils.type_string()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "latitude", "datatype": dbt_utils.type_float()},
    {"name": "locale_sid_key", "datatype": dbt_utils.type_string()},
    {"name": "longitude", "datatype": dbt_utils.type_float()},
    {"name": "manager_id", "datatype": dbt_utils.type_string()},
    {"name": "medium_banner_photo_url", "datatype": dbt_utils.type_string()},
    {"name": "mobile_phone", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string(), "alias": "user_name"},
    {"name": "offline_trial_expiration_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "phone", "datatype": dbt_utils.type_string()},
    {"name": "postal_code", "datatype": dbt_utils.type_string()},
    {"name": "profile_id", "datatype": dbt_utils.type_string()},
    {"name": "receives_admin_info_emails", "datatype": "boolean"},
    {"name": "receives_info_emails", "datatype": "boolean"},
    {"name": "sender_email", "datatype": dbt_utils.type_string()},
    {"name": "sender_name", "datatype": dbt_utils.type_string()},
    {"name": "signature", "datatype": dbt_utils.type_string()},
    {"name": "small_banner_photo_url", "datatype": dbt_utils.type_string()},
    {"name": "small_photo_url", "datatype": dbt_utils.type_string()},
    {"name": "state", "datatype": dbt_utils.type_string()},
    {"name": "state_code", "datatype": dbt_utils.type_string()},
    {"name": "street", "datatype": dbt_utils.type_string()},
    {"name": "time_zone_sid_key", "datatype": dbt_utils.type_string()},
    {"name": "title", "datatype": dbt_utils.type_string()},
    {"name": "user_role_id", "datatype": dbt_utils.type_string()},
    {"name": "user_type", "datatype": dbt_utils.type_string()},
    {"name": "username", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_user_role_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "case_access_for_account_owner", "datatype": dbt_utils.type_string()},
    {"name": "contact_access_for_account_owner", "datatype": dbt_utils.type_string()},
    {"name": "developer_name", "datatype": dbt_utils.type_string()},
    {"name": "forecast_user_id", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "user_role_id"},
    {"name": "may_forecast_manager_share", "datatype": "boolean"},
    {"name": "name", "datatype": dbt_utils.type_string(), "alias": "user_role_name"},
    {"name": "opportunity_access_for_account_owner", "datatype": dbt_utils.type_string()},
    {"name": "parent_role_id", "datatype": dbt_utils.type_string()},
    {"name": "portal_type", "datatype": dbt_utils.type_string()},
    {"name": "rollup_description", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

