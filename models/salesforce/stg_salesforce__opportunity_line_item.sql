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
        created_by_id,
        cast(created_date as {{ dbt.type_timestamp() }}) as created_date,
        description as opportunity_line_item_description,
        discount,
        has_quantity_schedule,
        has_revenue_schedule,
        has_schedule,
        is_deleted,
        last_modified_by_id,
        cast(last_modified_date as {{ dbt.type_timestamp() }}) as last_modified_date,
        cast(last_referenced_date as {{ dbt.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt.type_timestamp() }}) as last_viewed_date,
        list_price,
        name as opportunity_line_item_name,
        opportunity_id,
        pricebook_entry_id,
        product_2_id,
        product_code,
        quantity,
        cast(service_date as {{ dbt.type_timestamp() }}) as service_date,
        sort_order,
        total_price,
        unit_price
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__opportunity_line_item_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)