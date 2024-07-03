{% set column_list = get_account_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','account')),
                staging_columns=column_list
            )
        }}

    from {{ source('salesforce','account') }}
), 

final as (
    select
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("account_number", column_dict) }},
        {{ coalesce_rename("account_source", column_dict) }},
        {{ coalesce_rename("annual_revenue", column_dict) }},
        {{ coalesce_rename("billing_city", column_dict) }},
        {{ coalesce_rename("billing_country", column_dict) }},
        {{ coalesce_rename("billing_postal_code", column_dict) }},
        {{ coalesce_rename("billing_state", column_dict) }},
        {{ coalesce_rename("billing_state_code", column_dict) }},
        {{ coalesce_rename("billing_street", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="account_description" ) }},
        {{ coalesce_rename("id", column_dict, alias="account_id") }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("last_activity_date", column_dict) }},
        {{ coalesce_rename("last_referenced_date", column_dict) }},
        {{ coalesce_rename("last_viewed_date", column_dict) }},
        {{ coalesce_rename("master_record_id", column_dict) }},
        {{ coalesce_rename("name", column_dict, alias="account_named" ) }},
        {{ coalesce_rename("number_of_employees", column_dict) }},
        {{ coalesce_rename("owner_id", column_dict) }},
        {{ coalesce_rename("ownership", column_dict) }},
        {{ coalesce_rename("parent_id", column_dict) }},
        {{ coalesce_rename("rating", column_dict) }},
        {{ coalesce_rename("record_type_id", column_dict) }},
        {{ coalesce_rename("shipping_city", column_dict) }},
        {{ coalesce_rename("shipping_country", column_dict) }},
        {{ coalesce_rename("shipping_country_code", column_dict) }},
        {{ coalesce_rename("shipping_postal_code", column_dict) }},
        {{ coalesce_rename("shipping_state", column_dict) }},
        {{ coalesce_rename("shipping_state_code", column_dict) }},
        {{ coalesce_rename("shipping_street", column_dict) }},
        {{ coalesce_rename("type", column_dict) }},
        {{ coalesce_rename("website", column_dict) }}

        {{ fivetran_utils.fill_pass_through_columns('salesforce__account_pass_through_columns') }}

    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)