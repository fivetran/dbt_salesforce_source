--To disable this model, set the salesforce__opportunity_line_item_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__opportunity_line_item_enabled', True)) }}

{% set column_list = get_opportunity_line_item_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','opportunity_line_item')),
                staging_columns=column_list
            )
        }}
        
    from {{ source('salesforce','opportunity_line_item') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("id", column_dict, alias="opportunity_line_item_id") }},
        {{ coalesce_rename("created_by_id", column_dict) }},
        {{ coalesce_rename("created_date", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="opportunity_line_item_description") }},
        {{ coalesce_rename("discount", column_dict) }},
        {{ coalesce_rename("has_quantity_schedule", column_dict) }},
        {{ coalesce_rename("has_revenue_schedule", column_dict) }},
        {{ coalesce_rename("has_schedule", column_dict) }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("last_modified_by_id", column_dict) }},
        {{ coalesce_rename("last_modified_date", column_dict) }},
        {{ coalesce_rename("last_referenced_date", column_dict) }},
        {{ coalesce_rename("last_viewed_date", column_dict) }},
        {{ coalesce_rename("list_price", column_dict) }},
        {{ coalesce_rename("name", column_dict, alias="opportunity_line_item_name") }},
        {{ coalesce_rename("opportunity_id", column_dict) }},
        {{ coalesce_rename("pricebook_entry_id", column_dict) }},
        {{ coalesce_rename("product_2_id", column_dict) }},
        {{ coalesce_rename("product_code", column_dict) }},
        {{ coalesce_rename("quantity", column_dict) }},
        {{ coalesce_rename("service_date", column_dict) }},
        {{ coalesce_rename("sort_order", column_dict) }},
        {{ coalesce_rename("total_price", column_dict) }},
        {{ coalesce_rename("unit_price", column_dict) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__opportunity_line_item_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)