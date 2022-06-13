
with base as (

    select * 
    from {{ ref('stg_salesforce__opportunity_line_item_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__opportunity_line_item_tmp')),
                staging_columns=get_opportunity_line_item_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        created_by_id,
        created_date,
        description,
        discount,
        has_quantity_schedule,
        has_revenue_schedule,
        has_schedule,
        id,
        is_deleted,
        last_modified_by_id,
        last_modified_date,
        last_referenced_date,
        last_viewed_date,
        list_price,
        name,
        opportunity_id,
        pricebook_entry_id,
        product_2_id,
        product_code,
        quantity,
        service_date,
        sort_order,
        system_modstamp,
        total_price,
        unit_price
    from fields
)

select *
from final
