
with base as (

    select * 
    from {{ ref('stg_salesforce__order_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__order_tmp')),
                staging_columns=get_order_columns()
            )
        }}

        --The below script allows for pass through columns.
        {% if var('order_pass_through_columns',[]) != [] %}
        , {{ var('order_pass_through_columns') | join (", ")}}
        {% endif %}
        
    from base
), 

final as (
    
    select 
        _fivetran_synced,
        account_id,
        activated_by_id,
        activated_date,
        billing_city,
        billing_country,
        billing_country_code,
        billing_postal_code,
        billing_state,
        billing_state_code,
        billing_street,
        contract_id,
        created_by_id,
        created_date,
        customer_authorized_by_id,
        description,
        end_date,
        id,
        is_deleted,
        last_modified_by_id,
        last_modified_date,
        last_referenced_date,
        last_viewed_date,
        opportunity_id,
        order_number,
        original_order_id,
        owner_id,
        pricebook_2_id,
        shipping_city,
        shipping_country,
        shipping_country_code,
        shipping_postal_code,
        shipping_state,
        shipping_state_code,
        shipping_street,
        status,
        total_amount,
        type

        --The below script allows for pass through columns.
        {% if var('order_pass_through_columns',[]) != [] %}
        , {{ var('order_pass_through_columns') | join (", ")}}

        {% endif %}
        
    from fields
)

select *
from final
where not coalesce(is_deleted, false)