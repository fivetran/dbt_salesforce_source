with base as (

    select *
    from {{ ref('stg_salesforce__account_history_tmp') }}
), 

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__account_history_tmp')),
                staging_columns=get_account_history_columns()
            )
        }}

    from base
), 

final as (

    select 

        _fivetran_active,        
        cast(_fivetran_start as {{ dbt.type_timestamp() }}) as _fivetran_start,
        cast(_fivetran_end as {{ dbt.type_timestamp() }}) as _fivetran_end,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        account_number,
        account_source,
        cast(annual_revenue as {{ dbt.type_numeric() }}) as annual_revenue,
        billing_city,
        billing_country,
        billing_postal_code,
        billing_state, 
        billing_street,
        description as account_description,
        id as account_id,
        industry,
        is_deleted,
        cast(last_activity_date as {{ dbt.type_timestamp() }}) as last_activity_date,
        cast(last_referenced_date as {{ dbt.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt.type_timestamp() }}) as last_viewed_date,
        master_record_id,
        name as account_name,
        number_of_employees,
        owner_id,
        ownership,
        parent_id,
        rating,
        record_type_id,
        shipping_city,
        shipping_country,
        shipping_postal_code,
        shipping_state, 
        shipping_street,
        type,
        website
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__account_history_pass_through_columns') }}
        
    from fields
)

select *
from final
where not coalesce(is_deleted, false)