
{% macro get_opportunity_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "_fivetran_active", "datatype": "boolean"},
    {"name": "account_id", "datatype": dbt.type_string()},
    {"name": "accountid", "datatype": dbt.type_string()},
    {"name": "amount", "datatype": dbt.type_float()},
    {"name": "campaign_id", "datatype": dbt.type_string()},
    {"name": "campaignid", "datatype": dbt.type_string()},
    {"name": "close_date", "datatype": dbt.type_timestamp()},
    {"name": "closedate", "datatype": dbt.type_timestamp()},
    {"name": "created_date", "datatype": dbt.type_timestamp()},
    {"name": "createddate", "datatype": dbt.type_timestamp()},
    {"name": "description", "datatype": dbt.type_string()},
    {"name": "expected_revenue", "datatype": dbt.type_numeric()},
    {"name": "expectedrevenue", "datatype": dbt.type_numeric()},
    {"name": "fiscal", "datatype": dbt.type_string()},
    {"name": "fiscal_quarter", "datatype": dbt.type_int()},
    {"name": "fiscalquarter", "datatype": dbt.type_int()},
    {"name": "fiscal_year", "datatype": dbt.type_int()},
    {"name": "fiscalyear", "datatype": dbt.type_int()},
    {"name": "forecast_category", "datatype": dbt.type_string()},
    {"name": "forecastcategory", "datatype": dbt.type_string()},
    {"name": "forecast_category_name", "datatype": dbt.type_string()},
    {"name": "forecastcategoryname", "datatype": dbt.type_string()},
    {"name": "has_open_activity", "datatype": "boolean"},
    {"name": "hasopenactivity", "datatype": "boolean"},
    {"name": "has_opportunity_line_item", "datatype": "boolean"},
    {"name": "hasopportunitylineitem", "datatype": "boolean"},
    {"name": "has_overdue_task", "datatype": "boolean"},
    {"name": "hasoverduetask", "datatype": "boolean"},
    {"name": "id", "datatype": dbt.type_string()},
    {"name": "is_closed", "datatype": "boolean"},
    {"name": "isclosed", "datatype": "boolean"},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "isdeleted", "datatype": "boolean"},
    {"name": "is_won", "datatype": "boolean"},
    {"name": "iswon", "datatype": "boolean"},
    {"name": "last_activity_date", "datatype": dbt.type_timestamp()},
    {"name": "lastactivitydate", "datatype": dbt.type_timestamp()},
    {"name": "last_referenced_date", "datatype": dbt.type_timestamp()},
    {"name": "lastreferenceddate", "datatype": dbt.type_timestamp()},
    {"name": "last_viewed_date", "datatype": dbt.type_timestamp()},
    {"name": "lastvieweddate", "datatype": dbt.type_timestamp()},
    {"name": "lead_source", "datatype": dbt.type_string()},
    {"name": "leadsource", "datatype": dbt.type_string()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "next_step", "datatype": dbt.type_string()},
    {"name": "nextstep", "datatype": dbt.type_string()},
    {"name": "owner_id", "datatype": dbt.type_string()},
    {"name": "ownerid", "datatype": dbt.type_string()},
    {"name": "probability", "datatype": dbt.type_float()},
    {"name": "record_type_id", "datatype": dbt.type_string()},
    {"name": "recordtypeid", "datatype": dbt.type_string()},
    {"name": "stage_name", "datatype": dbt.type_string()},
    {"name": "stagename", "datatype": dbt.type_string()},
    {"name": "synced_quote_id", "datatype": dbt.type_string()},
    {"name": "syncedquoteid", "datatype": dbt.type_string()},
    {"name": "type", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('salesforce__opportunity_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}