with source as (

    select *
    from {{ ref('stg_salesforce__user_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__user_tmp')),
                staging_columns=get_user_columns()
            )
        }}

    from source

)

select * 
from renamed