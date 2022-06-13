
with base as (

    select * 
    from {{ ref('stg_salesforce__opportunity_line_item_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__opportunity_line_item_tmp')),
                staging_columns=get_opportunity_line_item_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        celigo_sfnsio_contract_item_id_c,
        celigo_sfnsio_contract_term_c,
        celigo_sfnsio_end_date_c,
        celigo_sfnsio_list_rate_c,
        celigo_sfnsio_net_suite_line_id_c,
        celigo_sfnsio_start_date_c,
        created_by_id,
        created_date,
        description,
        discount,
        event_volume_c,
        has_quantity_schedule,
        has_revenue_schedule,
        has_schedule,
        hvr_use_case_c,
        id,
        is_deleted,
        last_modified_by_id,
        last_modified_date,
        last_referenced_date,
        last_viewed_date,
        list_price,
        months_c,
        name,
        netsuite_conn_discount_item_c,
        netsuite_conn_end_date_c,
        netsuite_conn_from_contract_item_id_c,
        netsuite_conn_item_category_c,
        netsuite_conn_list_rate_c,
        netsuite_conn_net_suite_item_id_import_c,
        netsuite_conn_net_suite_item_key_id_c,
        netsuite_conn_pushed_from_net_suite_c,
        netsuite_conn_start_date_c,
        netsuite_conn_term_contract_pricing_type_c,
        netsuite_conn_terms_c,
        netsuite_conn_user_entered_sales_price_c,
        one_saas_app_included_c,
        one_saas_app_quantity_invoiced_c,
        one_saas_app_quantity_not_invoiced_c,
        opportunity_id,
        pricebook_entry_id,
        product_2_id,
        product_code,
        product_code_stamped_c,
        product_family_c,
        quantity,
        roadmap_connections_c,
        row_volume_c,
        sbqq_parent_id_c,
        sbqq_quote_line_c,
        sbqq_subscription_type_c,
        service_date,
        sort_order,
        system_modstamp,
        total_price,
        unit_price
    from fields
)

select *
from final
