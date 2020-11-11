with source as (

    select *
    from {{ ref('stg_salesforce__opportunity_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__opportunity_tmp')),
                staging_columns=get_opportunity_columns()
            )
        }}

    from source

),

calculated as (
        
    select 
        *,
        created_date >= {{ dbt_utils.date_trunc('month', dbt_utils.current_timestamp()) }} as is_created_this_month,
        created_date >= {{ dbt_utils.date_trunc('quarter', dbt_utils.current_timestamp()) }} as is_created_this_quarter,
        {{ dbt_utils.datediff(dbt_utils.current_timestamp(), 'created_date', 'day') }} as days_since_created,
        {{ dbt_utils.datediff('close_date', 'created_date', 'day') }} as days_to_close,
        {{ dbt_utils.date_trunc('month', 'close_date') }} = {{ dbt_utils.date_trunc('month', dbt_utils.current_timestamp()) }} as is_closed_this_month,
        {{ dbt_utils.date_trunc('quarter', 'close_date') }} = {{ dbt_utils.date_trunc('quarter', dbt_utils.current_timestamp()) }} as is_closed_this_quarter

    from renamed
    where not is_deleted

)

select * 
from renamed