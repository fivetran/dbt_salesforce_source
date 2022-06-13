
with base as (

    select * 
    from {{ ref('stg_salesforce__tasks_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__tasks_tmp')),
                staging_columns=get_tasks_columns()
            )
        }}
    from base
),

final as (
    
    select 
18:30:43  
    from fields
)

select *
from final
