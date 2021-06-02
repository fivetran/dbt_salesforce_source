with source as (

    select *
    from {{ ref('stg_salesforce__product_tmp') }}

), macro as (

    select
        /*
        The below macro is used to generate the correct SQL for package staging models. It takes a list of columns
        that are expected/needed (staging_columns from dbt_salesforce_source/models/tmp/) and compares it with columns
        in the source (source_columns from dbt_salesforce_source/macros/).

        For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
        */
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__product_tmp')),
                staging_columns=get_product_columns()
            )
        }}

      --The below script allows for pass through columns.

        {% if var('product_pass_through_columns') %}
        ,
        {{ var('product_pass_through_columns') | join (", ")}}

        {% endif %}

    from source

), renamed as (

    select
        id as product_id,
        _fivetran_synced,
        created_date,
        created_by_id,
        last_modified_date,
        last_modified_by_id,
        product_code,
        name,
        description,
        is_active,
        family,
        net_suite_product_id_c,
        shipping_sku_c,
        sellable_sku_c,
        net_suite_on_hand_c,
        warehouse_on_hand_c,
        is_deleted
      --The below script allows for pass through columns.

        {% if var('product_pass_through_columns') %}
        ,
        {{ var('product_pass_through_columns') | join (", ")}}

        {% endif %}

    from macro

), calculated as (

    select
        *
    from renamed

)

select *
from calculated
where not coalesce(is_deleted, false)
