--To disable this model, set the salesforce__order_enabled within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__order_enabled', True)) }}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','order')),
                staging_columns=get_order_columns()
            )
        }}
        
    from {{ source('salesforce','order') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        id as order_id,
        {{ coalesce_w_renamed_col('account_id') }},
        {{ coalesce_w_renamed_col('activated_by_id') }},
        {{ coalesce_w_renamed_col('activated_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('billing_city') }},
        {{ coalesce_w_renamed_col('billing_country') }},
        {{ coalesce_w_renamed_col('billing_country_code') }},
        {{ coalesce_w_renamed_col('billing_postal_code') }},
        {{ coalesce_w_renamed_col('billing_state') }},
        {{ coalesce_w_renamed_col('billing_state_code') }},
        {{ coalesce_w_renamed_col('billing_street') }},
        {{ coalesce_w_renamed_col('contract_id') }},
        {{ coalesce_w_renamed_col('created_by_id') }},
        {{ coalesce_w_renamed_col('created_date') }},
        description as order_description,
        {{ coalesce_w_renamed_col('end_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('is_deleted') }},
        {{ coalesce_w_renamed_col('last_modified_by_id') }},
        {{ coalesce_w_renamed_col('last_modified_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_referenced_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_viewed_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('opportunity_id') }},
        {{ coalesce_w_renamed_col('order_number') }},
        {{ coalesce_w_renamed_col('original_order_id') }},
        {{ coalesce_w_renamed_col('owner_id') }},
        {{ coalesce_w_renamed_col('pricebook_2_id') }},
        {{ coalesce_w_renamed_col('shipping_city') }},
        {{ coalesce_w_renamed_col('shipping_country') }},
        {{ coalesce_w_renamed_col('shipping_country_code') }},
        {{ coalesce_w_renamed_col('shipping_postal_code') }},
        {{ coalesce_w_renamed_col('shipping_state') }},
        {{ coalesce_w_renamed_col('shipping_state_code') }},
        {{ coalesce_w_renamed_col('shipping_street') }},
        status,
        {{ coalesce_w_renamed_col('total_amount') }},
        type
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__order_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)