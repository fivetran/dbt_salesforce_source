{{ config(enabled=var('salesforce__product_2_history_enabled', False)) }}

with base as (

    select *
    from {{ ref('stg_salesforce__product_2_history_tmp') }}
), 

fields as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__product_2_history_tmp')),
                staging_columns=get_product_2_history_columns()
            )
        }}

    from base
), 

final as (

    select
        id as product_2_id,
        _fivetran_active,
        _fivetran_end,
        _fivetran_start,
        _fivetran_synced,
        created_by_id,
        cast(created_date as {{ dbt.type_timestamp() }}) as created_date,
        description as product_2_description,
        display_url,
        external_id,
        family,
        is_active,
        is_archived,
        is_deleted,
        last_modified_by_id,
        cast(last_modified_date as {{ dbt.type_timestamp() }}) as last_modified_date,
        cast(last_referenced_date as {{ dbt.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt.type_timestamp() }}) as last_viewed_date,
        name as product_2_name,
        number_of_quantity_installments,
        number_of_revenue_installments,
        product_code,
        quantity_installment_period,
        quantity_schedule_type,
        quantity_unit_of_measure,
        record_type_id,
        revenue_installment_period,
        revenue_schedule_type
        {{ fivetran_utils.add_pass_through_columns(columns, var('salesforce__product_2_history_pass_through_columns')) }}

    from fields
)

select *
from final
where not coalesce(is_deleted, false)