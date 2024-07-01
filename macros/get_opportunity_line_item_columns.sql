{% macro get_opportunity_line_item_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "_fivetran_active", "datatype": dbt.type_boolean()},
    {"name": "created_by_id", "datatype": dbt.type_string()},
    {"name": "createdbyid", "datatype": dbt.type_string()},
    {"name": "created_date", "datatype": dbt.type_timestamp()},
    {"name": "createddate", "datatype": dbt.type_timestamp()},
    {"name": "description", "datatype": dbt.type_string()},
    {"name": "discount", "datatype": dbt.type_float()},
    {"name": "has_quantity_schedule", "datatype": dbt.type_boolean()},
    {"name": "hasquantityschedule", "datatype": dbt.type_boolean()},
    {"name": "has_revenue_schedule", "datatype": dbt.type_boolean()},
    {"name": "hasrevenueschedule", "datatype": dbt.type_boolean()},
    {"name": "has_schedule", "datatype": dbt.type_boolean()},
    {"name": "hasschedule", "datatype": dbt.type_boolean()},
    {"name": "id", "datatype": dbt.type_string()},
    {"name": "is_deleted", "datatype": dbt.type_boolean()},
    {"name": "isdeleted", "datatype": dbt.type_boolean()},
    {"name": "last_modified_by_id", "datatype": dbt.type_string()},
    {"name": "lastmodifiedbyid", "datatype": dbt.type_string()},
    {"name": "last_modified_date", "datatype": dbt.type_timestamp()},
    {"name": "lastmodifieddate", "datatype": dbt.type_timestamp()},
    {"name": "last_referenced_date", "datatype": dbt.type_timestamp()},
    {"name": "lastreferenceddate", "datatype": dbt.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt.type_timestamp()},
    {"name": "lastvieweddate", "datatype": dbt.type_timestamp()},
    {"name": "list_price", "datatype": dbt.type_float()},
    {"name": "listprice", "datatype": dbt.type_float()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "opportunity_id", "datatype": dbt.type_string()},
    {"name": "opportunityid", "datatype": dbt.type_string()},
    {"name": "pricebook_entry_id", "datatype": dbt.type_string()},
    {"name": "pricebookentryid", "datatype": dbt.type_string()},
    {"name": "product_2_id", "datatype": dbt.type_string()},
    {"name": "product2id", "datatype": dbt.type_string()},
    {"name": "product_code", "datatype": dbt.type_string()},
    {"name": "productcode", "datatype": dbt.type_string()},
    {"name": "quantity", "datatype": dbt.type_float()},
    {"name": "service_date", "datatype": dbt.type_timestamp()},
    {"name": "servicedate", "datatype": dbt.type_timestamp()},
    {"name": "sort_order", "datatype": dbt.type_int()},
    {"name": "sortorder", "datatype": dbt.type_int()},
    {"name": "total_price", "datatype": dbt.type_float()},
    {"name": "totalprice", "datatype": dbt.type_float()},
    {"name": "unit_price", "datatype": dbt.type_float()},
    {"name": "unitprice", "datatype": dbt.type_float()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('salesforce__opportunity_line_item_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}
