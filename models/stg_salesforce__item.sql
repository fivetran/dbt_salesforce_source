with source as (

    select *
    from {{ ref('stg_salesforce__item_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__item_tmp')),
                staging_columns=get_item_columns()
            )
        }}

      --The below script allows for pass through columns.

        {% if var('item_pass_through_columns') %}
        ,
        {{ var('item_pass_through_columns') | join (", ")}}

        {% endif %}

    from source

), renamed as (

    select
        id as item_id,
        order_item_name,
        _fivetran_synced,
        order_id,
        created_date,
        created_by_id,
        last_modified_date,
        last_modified_by_id,
        is_deleted

      --The below script allows for pass through columns.

        {% if var('item_pass_through_columns') %}
        ,
        {{ var('item_pass_through_columns') | join (", ")}}

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
