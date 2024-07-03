--To disable this model, set the salesforce__product_2_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__product_2_enabled', True)) }}

{% set column_list = get_product_2_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','product_2')),
                staging_columns=column_list
            )
        }}
        
    from {{ source('salesforce','product_2') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("id", column_dict, alias="product_2_id") }},
        {{ coalesce_rename("created_by_id", column_dict) }},
        {{ coalesce_rename("created_date", column_dict) }},
        {{ coalesce_rename("description", column_dict, alias="product_2_description") }},
        {{ coalesce_rename("display_url", column_dict) }},
        {{ coalesce_rename("external_id", column_dict) }},
        {{ coalesce_rename("family", column_dict) }},
        {{ coalesce_rename("is_active", column_dict) }},
        {{ coalesce_rename("is_archived", column_dict) }},
        {{ coalesce_rename("is_deleted", column_dict) }},
        {{ coalesce_rename("last_modified_by_id", column_dict) }},
        {{ coalesce_rename("last_modified_date", column_dict) }},
        {{ coalesce_rename("last_referenced_date", column_dict) }},
        {{ coalesce_rename("last_viewed_date", column_dict) }},
        {{ coalesce_rename("name", column_dict, alias="product_2_name") }},
        {{ coalesce_rename("number_of_quantity_installments", column_dict) }},
        {{ coalesce_rename("number_of_revenue_installments", column_dict) }},
        {{ coalesce_rename("product_code", column_dict) }},
        {{ coalesce_rename("quantity_installment_period", column_dict) }},
        {{ coalesce_rename("quantity_schedule_type", column_dict) }},
        {{ coalesce_rename("quantity_unit_of_measure", column_dict) }},
        {{ coalesce_rename("record_type_id", column_dict) }},
        {{ coalesce_rename("revenue_installment_period", column_dict) }},
        {{ coalesce_rename("revenue_schedule_type", column_dict) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__product_2_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)