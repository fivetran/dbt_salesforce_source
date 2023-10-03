{{ config(enabled=var('lead_history_enabled', False)) }}

with base as (

    select * 
    from {{ ref('stg_salesforce__lead_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__lead_history_tmp')),
                staging_columns=get_lead_history_columns()
            )
        }}
        
    from base
), 

final as (
    
    select 
        id as lead_id,
        _fivetran_active,        
        cast(_fivetran_start as {{ dbt.type_timestamp() }}) as _fivetran_start,
        cast(_fivetran_end as {{ dbt.type_timestamp() }}) as _fivetran_end,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        annual_revenue,
        city,
        company,
        converted_account_id,
        converted_contact_id,
        cast(converted_date as {{ dbt.type_timestamp() }}) as converted_date,
        converted_opportunity_id,
        country,
        created_by_id,
        cast(created_date as {{ dbt.type_timestamp() }}) as created_date,
        description as lead_description,
        email,
        cast(email_bounced_date as {{ dbt.type_timestamp() }}) as email_bounced_date,
        email_bounced_reason,
        first_name,
        has_opted_out_of_email,
        individual_id,
        industry,
        is_converted,
        is_deleted,
        is_unread_by_owner,
        cast(last_activity_date as {{ dbt.type_timestamp() }}) as last_activity_date,
        last_modified_by_id,
        cast(last_modified_date as {{ dbt.type_timestamp() }}) as last_modified_date,
        last_name,
        cast(last_referenced_date as {{ dbt.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt.type_timestamp() }}) as last_viewed_date,
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
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__lead_history_pass_through_columns') }}
        
    from fields
)

select *
from final
where not coalesce(is_deleted, false)