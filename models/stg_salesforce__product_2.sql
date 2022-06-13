
with base as (

    select * 
    from {{ ref('stg_salesforce__product_2_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__product_2_tmp')),
                staging_columns=get_product_2_columns()
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
        display_url,
        external_id,
        family,
        id,
        is_active,
        is_archived,
        is_deleted,
        last_modified_by_id,
        last_modified_date,
        last_referenced_date,
        last_viewed_date,
        name,
        number_of_quantity_installments,
        number_of_revenue_installments,
        product_code,
        quantity_installment_period,
        quantity_schedule_type,
        quantity_unit_of_measure,
        record_type_id,
        revenue_installment_period,
        revenue_schedule_type
    from fields
)

select *
from final
