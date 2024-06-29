--To disable this model, set the salesforce__product_2_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__product_2_enabled', True)) }}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','product_2')),
                staging_columns=get_product_2_columns()
            )
        }}
        
    from {{ source('salesforce','product_2') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        id as product_2_id,
        {{ coalesce_w_renamed_col('created_by_id') }},
        {{ coalesce_w_renamed_col('created_date', datatype=dbt.type_timestamp()) }},
        description as product_2_description,
        {{ coalesce_w_renamed_col('display_url') }},
        {{ coalesce_w_renamed_col('external_id') }},
        family,
        {{ coalesce_w_renamed_col('is_active') }},
        {{ coalesce_w_renamed_col('is_archived') }},
        {{ coalesce_w_renamed_col('is_deleted') }},
        {{ coalesce_w_renamed_col('last_modified_by_id') }},
        {{ coalesce_w_renamed_col('last_modified_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_referenced_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_viewed_date', datatype=dbt.type_timestamp()) }},
        name as product_2_name,
        {{ coalesce_w_renamed_col('number_of_quantity_installments') }},
        {{ coalesce_w_renamed_col('number_of_revenue_installments') }},
        {{ coalesce_w_renamed_col('product_code') }},
        {{ coalesce_w_renamed_col('quantity_installment_period') }},
        {{ coalesce_w_renamed_col('quantity_schedule_type') }},
        {{ coalesce_w_renamed_col('quantity_unit_of_measure') }},
        {{ coalesce_w_renamed_col('record_type_id') }},
        {{ coalesce_w_renamed_col('revenue_installment_period') }},
        {{ coalesce_w_renamed_col('revenue_schedule_type') }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__product_2_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)