
with base as (

    select * 
    from {{ ref('stg_salesforce__product_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__product_tmp')),
                staging_columns=get_product_columns()
            )
        }}
    from base
),

final as (
    
    select 
18:30:53  
    from fields
)

select *
from final
