with base as (

    select *
    from {{ ref('stg_salesforce__account_tmp') }}
), 

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__account_tmp')),
                staging_columns=get_account_columns()
            )
        }}

        --The below script allows for pass through columns.
        {% if var('account_pass_through_columns',[]) != [] %}
        , {{ var('account_pass_through_columns') | join (", ")}}
        {% endif %}
        
    from base
), 

final as (

    select 
        cast(_fivetran_synced as {{ dbt_utils.type_timestamp() }}) as _fivetran_synced,
        account_number,
        account_source,
        cast(annual_revenue as {{ dbt_utils.type_numeric() }}) as annual_revenue,
        billing_city,
        billing_country,
        billing_postal_code,
        billing_state,
        billing_state_code,
        billing_street,
        description as account_description,
        id as account_id,
        industry,
        is_deleted,
        cast(last_activity_date as {{ dbt_utils.type_timestamp() }}) as last_activity_date,
        cast(last_referenced_date as {{ dbt_utils.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt_utils.type_timestamp() }}) as last_viewed_date,
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
        shipping_country_code,
        shipping_postal_code,
        shipping_state,
        shipping_state_code,
        shipping_street,
        type,
        website

        --The below script allows for pass through columns.
        {% if var('account_pass_through_columns',[]) != [] %}
        , {{ var('account_pass_through_columns') | join (", ")}}

        {% endif %}
        
    from fields
)

select *
from final
where not coalesce(is_deleted, false)