with source as (

    select *
    from {{ ref('stg_salesforce__order_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__order_tmp')),
                staging_columns=get_order_columns()
            )
        }}

      --The below script allows for pass through columns.

        {% if var('order_pass_through_columns') %}
        ,
        {{ var('order_pass_through_columns') | join (", ")}}

        {% endif %}

    from source

), renamed as (

    select
        id as order_id,
        macro.name as order_name,
        _fivetran_synced,
        account_id,
        total_amount,
        activated_by_id,
        activated_date,
        created_by_id,
        created_date,
        last_modified_by_id,
        last_modified_date,
        effective_date,
        end_date,
        status,
        status_code,
        order_number,
        owner_id,
        Pricebook2Id,
        record_type_id,
        bill_to_contact_id,
        billing_city,
        billing_country,
        billing_country_code,
        billing_postal_code,
        billing_state,
        billing_state_code,
        billing_street,
        ship_to_contact_id,
        shipping_city,
        shipping_country,
        shipping_country_code,
        shipping_postal_code,
        shipping_state,
        shipping_state_code,
        shipping_street,
        type,
        is_deleted

      --The below script allows for pass through columns.

        {% if var('order_pass_through_columns') %}
        ,
        {{ var('order_pass_through_columns') | join (", ")}}

        {% endif %}

    from macro

), calculated as (

    select
        *,
        {{ dbt_utils.date_trunc('month', 'effective_date') }} = {{ dbt_utils.date_trunc('month', dbt_utils.current_timestamp()) }} as is_closed_this_month,
        {{ dbt_utils.date_trunc('quarter', 'effective_date') }} = {{ dbt_utils.date_trunc('quarter', dbt_utils.current_timestamp()) }} as is_closed_this_quarter

    from renamed

)

select *
from calculated
where not coalesce(is_deleted, false)
