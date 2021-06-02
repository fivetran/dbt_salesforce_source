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
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_closed", "datatype": "boolean"},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "is_won", "datatype": "boolean"},
    {"name": "last_activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_referenced_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "lead_source", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "next_step", "datatype": dbt_utils.type_string()},
    {"name": "owner_id", "datatype": dbt_utils.type_string()},
    {"name": "probability", "datatype": dbt_utils.type_float()},
    {"name": "record_type_id", "datatype": dbt_utils.type_string()},
    {"name": "stage_name", "datatype": dbt_utils.type_string()},
    {"name": "synced_quote_id", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}


{% macro get_order_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "billing_account_c", "datatype": dbt_utils.type_string()},
    {"name": "end_user_c", "datatype": dbt_utils.type_string()},
    {"name": "company_name_c", "datatype": dbt_utils.type_string()},
    {"name": "total_amount", "datatype": dbt_utils.type_float()},
    {"name": "activated_by_id", "datatype": dbt_utils.type_string()},
    {"name": "activated_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "created_by_id", "datatype": dbt_utils.type_string()},
    {"name": "created_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_modified_by_id", "datatype": dbt_utils.type_string()},
    {"name": "last_modified_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "effective_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "end_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "pilot_end_date_c", "datatype": dbt_utils.type_timestamp()},
    {"name": "actual_ship_date_c", "datatype": dbt_utils.type_timestamp()},
    {"name": "class_c", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "memo_c", "datatype": dbt_utils.type_string()},
    {"name": "internal_notes_c", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "status_code", "datatype": dbt_utils.type_string()},
    {"name": "pro_install_c", "datatype": boolean},
    {"name": "split_order_c", "datatype": dbt_utils.type_string()},
    {"name": "terms_c", "datatype": dbt_utils.type_string()},
    {"name": "net_suite_order_id_c", "datatype": dbt_utils.type_string()},
    {"name": "terms_c", "datatype": dbt_utils.type_string()},
    {"name": "net_suite_sales_order_ref_id_c", "datatype": dbt_utils.type_string()},
    {"name": "record_type_id", "datatype": dbt_utils.type_string()},
    {"name": "order_number", "datatype": dbt_utils.type_int()},
    {"name": "owner_id", "datatype": dbt_utils.type_string()},
    {"name": "Pricebook2Id", "datatype": dbt_utils.type_string()},
    {"name": "record_type_id", "datatype": dbt_utils.type_string()},
    {"name": "branch_id_c", "datatype": dbt_utils.type_string()},
    {"name": "bill_to_contact_id", "datatype": dbt_utils.type_string()},
    {"name": "billing_city", "datatype": dbt_utils.type_string()},
    {"name": "billing_country", "datatype": dbt_utils.type_string()},
    {"name": "billing_country_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_state", "datatype": dbt_utils.type_string()},
    {"name": "billing_state_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_street", "datatype": dbt_utils.type_string()},
    {"name": "shipping_city", "datatype": dbt_utils.type_string()},
    {"name": "shipping_country", "datatype": dbt_utils.type_string()},
    {"name": "shipping_country_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_state", "datatype": dbt_utils.type_string()},
    {"name": "shipping_state_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_street", "datatype": dbt_utils.type_string()},
    {"name": "stage_name", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}

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

{% macro get_item_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "order_id", "datatype": dbt_utils.type_string()},
    {"name": "created_by_id", "datatype": dbt_utils.type_string()},
    {"name": "created_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "last_modified_by_id", "datatype": dbt_utils.type_string()},
    {"name": "last_modified_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "pricebook_entry_id", "datatype": dbt_utils.type_string()},
    {"name": "product_2_id", "datatype": dbt_utils.type_string()},
    {"name": "product_family_c", "datatype": dbt_utils.type_string()},
    {"name": "product_code_text_c", "datatype": dbt_utils.type_string()},
    {"name": "net_suite_product_id_c", "datatype": dbt_utils.type_string()},
    {"name": "quantity", "datatype": dbt_utils.type_int()},
    {"name": "unit_price", "datatype": dbt_utils.type_float()},
    {"name": "total_price", "datatype": dbt_utils.type_float()},
    {"name": "total_price_custom_c", "datatype": dbt_utils.type_float()},
    {"name": "serial_numbers_c", "datatype": dbt_utils.type_string()},
    {"name": "subscription_months_c", "datatype": dbt_utils.type_int()},
    {"name": "subscription_units_c", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
