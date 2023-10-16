{{ config(enabled=var('salesforce__opportunity_line_item_history_enabled', False)) }}

with base as (

    select *
    from {{ ref('stg_salesforce__opportunity_line_item_history_tmp') }}
), 

fields as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__opportunity_line_item_history_tmp')),
                staging_columns=get_opportunity_line_item_history_columns()
            )
        }}

    from base
), 

final as (

    select
        id as opportunity_line_item_id,
        _fivetran_active,
        _fivetran_end,
        _fivetran_start,
        _fivetran_synced,
        created_by_id,
        cast(created_date as {{ dbt.type_timestamp() }}) as created_date,
        description as opportunity_line_item_description,
        discount,
        has_quantity_schedule,
        has_revenue_schedule,
        has_schedule,
        is_deleted,
        last_modified_by_id,
        cast(last_modified_date as {{ dbt.type_timestamp() }}) as last_modified_date,
        cast(last_referenced_date as {{ dbt.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt.type_timestamp() }}) as last_viewed_date,
        list_price,
        name as opportunity_line_item_name,
        opportunity_id,
        pricebook_entry_id,
        product_2_id,
        product_code,
        quantity,
        cast(service_date as {{ dbt.type_timestamp() }}) as service_date,
        sort_order,
        total_price,
        unit_price

        {{ fivetran_utils.fill_pass_through_columns('salesforce__opportunity_line_item_history_pass_through_columns') }}

    from fields

)

select *
from final
where not coalesce(is_deleted, false)