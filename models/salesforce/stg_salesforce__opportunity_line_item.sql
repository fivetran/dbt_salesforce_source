--To disable this model, set the salesforce__opportunity_line_item_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__opportunity_line_item_enabled', True)) }}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','opportunity_line_item')),
                staging_columns=get_opportunity_line_item_columns()
            )
        }}
        
    from {{ source('salesforce','opportunity_line_item') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        id as opportunity_line_item_id,
        {{ coalesce_w_renamed_col('created_by_id') }},
        {{ coalesce_w_renamed_col('created_date', datatype=dbt.type_timestamp()) }},
        description as opportunity_line_item_description,
        discount,
        {{ coalesce_w_renamed_col('has_quantity_schedule') }},
        {{ coalesce_w_renamed_col('has_revenue_schedule') }},
        {{ coalesce_w_renamed_col('has_schedule') }},
        {{ coalesce_w_renamed_col('is_deleted') }},
        {{ coalesce_w_renamed_col('last_modified_by_id') }},
        {{ coalesce_w_renamed_col('last_modified_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_referenced_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_viewed_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('list_price') }},
        name as opportunity_line_item_name,
        {{ coalesce_w_renamed_col('opportunity_id') }},
        {{ coalesce_w_renamed_col('pricebook_entry_id') }},
        {{ coalesce_w_renamed_col('product_2_id') }},
        {{ coalesce_w_renamed_col('product_code') }},
        quantity,
        {{ coalesce_w_renamed_col('service_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('sort_order') }},
        {{ coalesce_w_renamed_col('total_price') }},
        {{ coalesce_w_renamed_col('unit_price') }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__opportunity_line_item_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)