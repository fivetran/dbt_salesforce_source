with source as (

    select 
      *
    from {{ ref('stg_salesforce__account_tmp') }}

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
              source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__account_tmp')),
              staging_columns=get_account_columns()
          )
      }}

      --The below script allows for pass through columns.
      {% if var('account_pass_through_columns') %}
      ,
      {{ var('account_pass_through_columns') | join (", ")}}

      {% endif %}
        
    from source

), renamed as (

    select 
      _fivetran_synced,
      account_number,
      account_source,
      annual_revenue,
      billing_city,
      billing_country,
      billing_postal_code,
      billing_state,
      billing_state_code,
      billing_street,
      description,
      id as account_id,
      industry,
      is_deleted,
      last_activity_date,
      last_referenced_date,
      last_viewed_date,
      master_record_id,
      name as account_name,
      number_of_employees,
      owner_id,
      ownership,
      parent_id,
      rating,
      record_type_id,
      shipping_city,
      shipping_country,
      shipping_country_code,
      shipping_postal_code,
      shipping_state,
      shipping_state_code,
      shipping_street,
      type,
      website

      --The below script allows for pass through columns.
      {% if var('account_pass_through_columns') %}
      ,
      {{ var('account_pass_through_columns') | join (", ")}}

      {% endif %}
      
    from macro
)

select *
from renamed
where not is_deleted