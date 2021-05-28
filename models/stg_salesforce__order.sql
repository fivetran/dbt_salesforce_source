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
        macro.name as order_name,
_fivetran_synced,account_id,activated_date,effective_date,end_date,pilot_end_date_c,description,internal_notes_c,id,is_deleted,owner_id,
        /* id as order_id,
        name as order_name,
record_type_id,        */
        type

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
