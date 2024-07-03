--To disable this model, set the salesforce__order_enabled within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__order_enabled', True)) }}

{% set column_list = get_order_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','order')),
                staging_columns=column_list
            )
        }}
        
    from {{ source('salesforce','order') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("id", column_dict, alias="order_id") }},
        {{ coalesce_rename("account_id", column_dict) }},
        {{ coalesce_rename("activated_by_id", column_dict) }},
        {{ coalesce_rename("activated_date", column_dict) }},
        {{ coalesce_rename("billing_city", column_dict) }},
        {{ coalesce_rename("billing_country", column_dict) }},
        {{ coalesce_rename("billing_country_code", column_dict) }},
        {{ coalesce_rename("billing_postal_code", column_dict) }},
        {{ coalesce_rename("billing_state", column_dict) }},
        {{ coalesce_rename("billing_state_code", column_dict) }},
        {{ coalesce_rename("billing_street", column_dict) }},
        {{ coalesce_rename("contract_id", column_dict) }},
        {{ coalesce_rename("created_by_id", column_dict) }},
        {{ coalesce_rename("created_date", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="order_description") }},
        {{ coalesce_rename("end_date", column_dict) }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("last_modified_by_id", column_dict) }},
        {{ coalesce_rename("last_modified_date", column_dict) }},
        {{ coalesce_rename("last_referenced_date", column_dict) }},
        {{ coalesce_rename("last_viewed_date", column_dict) }},
        {{ coalesce_rename("opportunity_id", column_dict) }},
        {{ coalesce_rename("order_number", column_dict) }},
        {{ coalesce_rename("original_order_id", column_dict) }},
        {{ coalesce_rename("owner_id", column_dict) }},
        {{ coalesce_rename("pricebook_2_id", column_dict) }},
        {{ coalesce_rename("shipping_city", column_dict) }},
        {{ coalesce_rename("shipping_country", column_dict) }},
        {{ coalesce_rename("shipping_country_code", column_dict) }},
        {{ coalesce_rename("shipping_postal_code", column_dict) }},
        {{ coalesce_rename("shipping_state", column_dict) }},
        {{ coalesce_rename("shipping_state_code", column_dict) }},
        {{ coalesce_rename("shipping_street", column_dict) }},
        {{ coalesce_rename("status", column_dict) }},
        {{ coalesce_rename("total_amount", column_dict) }},
        {{ coalesce_rename("type", column_dict) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__order_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)