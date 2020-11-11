with source as (

    select *
    from {{ ref('stg_salesforce__user_role_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__user_role_tmp')),
                staging_columns=get_user_role_columns()
            )
        }}

    from source

)

select * 
from renamed
where not _fivetran_deleted
