with source as (

    select *
    from {{ ref('stg_salesforce__user_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__user_tmp')),
                staging_columns=get_user_columns()
            )
        }}

      --The below script allows for pass through columns.

        {% if var('user_pass_through_columns') %}
        ,
        {{ var('user_pass_through_columns') | join (", ")}}

        {% endif %}

    from source

), renamed as (
    
    select 

        _fivetran_deleted,
        _fivetran_synced,
        account_id,
        alias,
        city,
        company_name,
        contact_id,
        country,
        country_code,
        department,
        email,
        first_name,
        id as user_id,
        individual_id,
        is_active,
        last_login_date,
        last_name,
        last_referenced_date,
        last_viewed_date,
        manager_id,
        name as user_name,
        postal_code,
        profile_id,
        state,
        state_code,
        street,
        title,
        user_role_id,
        user_type,
        username 
      --The below script allows for pass through columns.

        {% if var('user_pass_through_columns') %}
        ,
        {{ var('user_pass_through_columns') | join (", ")}}

        {% endif %}
    
    from macro

)

select * 
from renamed
where not coalesce(_fivetran_deleted, false)