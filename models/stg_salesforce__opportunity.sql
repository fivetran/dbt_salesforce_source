with source as (

    select *
    from {{ ref('stg_salesforce__opportunity_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__opportunity_tmp')),
                staging_columns=get_opportunity_columns()
            )
        }}

      --The below script allows for pass through columns.

        {% if var('opportunity_pass_through_columns') %}
        ,
        {{ var('opportunity_pass_through_columns') | join (", ")}}

        {% endif %}

    from source

), renamed as (
    
    select 

        _fivetran_synced,
        account_id,
        cast(amount as {{ dbt_utils.type_float() }}) as amount,
        campaign_id,
        close_date,
        created_date,
        description,
        cast(expected_revenue as {{ dbt_utils.type_float() }}) as expected_revenue,
        fiscal,
        fiscal_quarter,
        fiscal_year,
        forecast_category,
        forecast_category_name,
        has_open_activity,
        has_opportunity_line_item,
        has_overdue_task,
        id as opportunity_id,
        is_closed,
        is_deleted,
        is_won,
        last_activity_date,
        last_referenced_date,
        last_viewed_date,
        lead_source,
        name as opportunity_name,
        next_step,
        owner_id,
        probability,
        record_type_id,
        stage_name,
        synced_quote_id,
        type

      --The below script allows for pass through columns.

        {% if var('opportunity_pass_through_columns') %}
        ,
        {{ var('opportunity_pass_through_columns') | join (", ")}}

        {% endif %}

    from macro

), calculated as (
        
    select 
        *,
        created_date >= {{ dbt_utils.date_trunc('month', dbt_utils.current_timestamp()) }} as is_created_this_month,
        created_date >= {{ dbt_utils.date_trunc('quarter', dbt_utils.current_timestamp()) }} as is_created_this_quarter,
        {{ dbt_utils.datediff(dbt_utils.current_timestamp(), 'created_date', 'day') }} as days_since_created,
        {{ dbt_utils.datediff('close_date', 'created_date', 'day') }} as days_to_close,
        {{ dbt_utils.date_trunc('month', 'close_date') }} = {{ dbt_utils.date_trunc('month', dbt_utils.current_timestamp()) }} as is_closed_this_month,
        {{ dbt_utils.date_trunc('quarter', 'close_date') }} = {{ dbt_utils.date_trunc('quarter', dbt_utils.current_timestamp()) }} as is_closed_this_quarter

    from renamed

)

select * 
from calculated
where not coalesce(is_deleted, false)