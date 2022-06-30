--To disable this model, set the using_user_role variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__lead_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_salesforce__lead_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__lead_tmp')),
                staging_columns=get_lead_columns()
            )
        }}

        --The below script allows for pass through columns.
        {% if var('lead_pass_through_columns',[]) != [] %}
        , {{ var('lead_pass_through_columns') | join (", ")}}
        {% endif %}
        
    from base
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt_utils.type_timestamp() }}) as _fivetran_synced,
        id as lead_id,
        annual_revenue,
        city,
        company,
        converted_account_id,
        converted_contact_id,
        cast(converted_date as {{ dbt_utils.type_timestamp() }}) as converted_date,
        converted_opportunity_id,
        country,
        country_code,
        created_by_id,
        cast(created_date as {{ dbt_utils.type_timestamp() }}) as created_date,
        description as lead_description,
        email,
        cast(email_bounced_date as {{ dbt_utils.type_timestamp() }}) as email_bounced_date,
        email_bounced_reason,
        first_name,
        has_opted_out_of_email,
        individual_id,
        industry,
        is_converted,
        is_deleted,
        is_unread_by_owner,
        cast(last_activity_date as {{ dbt_utils.type_timestamp() }}) as last_activity_date,
        last_modified_by_id,
        cast(last_modified_date as {{ dbt_utils.type_timestamp() }}) as last_modified_date,
        last_name,
        cast(last_referenced_date as {{ dbt_utils.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt_utils.type_timestamp() }}) as last_viewed_date,
        lead_source,
        master_record_id,
        mobile_phone,
        name as lead_name,
        number_of_employees,
        owner_id,
        phone,
        postal_code,
        state,
        state_code,
        status,
        street,
        title,
        website

        --The below script allows for pass through columns.
        {% if var('lead_pass_through_columns',[]) != [] %}
        , {{ var('lead_pass_through_columns') | join (", ")}}

        {% endif %}
        
    from fields
)

select *
from final
where not coalesce(is_deleted, false)