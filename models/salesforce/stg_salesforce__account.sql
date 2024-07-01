with fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','account')),
                staging_columns=get_account_columns()
            )
        }}

    from {{ source('salesforce','account') }}
), 

final as (

    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_w_renamed_col('account_number') }},
        {{ coalesce_w_renamed_col('account_source') }},
        {{ coalesce_w_renamed_col('annual_revenue', datatype=dbt.type_numeric()) }},
        {{ coalesce_w_renamed_col('billing_city') }},
        {{ coalesce_w_renamed_col('billing_country') }},
        {{ coalesce_w_renamed_col('billing_postal_code') }},
        {{ coalesce_w_renamed_col('billing_state') }},
        {{ coalesce_w_renamed_col('billing_state_code') }},
        {{ coalesce_w_renamed_col('billing_street') }},
        description as account_description,
        id as account_id,
        industry,
        {{ coalesce_w_renamed_col('is_deleted', datatype=dbt.type_boolean()) }},
        {{ coalesce_w_renamed_col('last_activity_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_referenced_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_viewed_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('master_record_id') }},
        name as account_name,
        {{ coalesce_w_renamed_col('number_of_employees', datatype=dbt.type_int()) }},
        {{ coalesce_w_renamed_col('owner_id') }},
        ownership,
        {{ coalesce_w_renamed_col('parent_id') }},
        rating,
        {{ coalesce_w_renamed_col('record_type_id') }},
        {{ coalesce_w_renamed_col('shipping_city') }},
        {{ coalesce_w_renamed_col('shipping_country') }},
        {{ coalesce_w_renamed_col('shipping_country_code') }},
        {{ coalesce_w_renamed_col('shipping_postal_code') }},
        {{ coalesce_w_renamed_col('shipping_state') }},
        {{ coalesce_w_renamed_col('shipping_state_code') }},
        {{ coalesce_w_renamed_col('shipping_street') }},
        type,
        website
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__account_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)