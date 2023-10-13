{{ config(enabled=var('salesforce__contact_history_enabled', False)) }}

with base as (

    select * 
    from {{ ref('stg_salesforce__contact_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__contact_history_tmp')),
                staging_columns=get_contact_history_columns()
            )
        }}
        
    from base
), 

final as (
    
    select 
        id as contact_id,
        _fivetran_active,        
        cast(_fivetran_start as {{ dbt.type_timestamp() }}) as _fivetran_start,
        cast(_fivetran_end as {{ dbt.type_timestamp() }}) as _fivetran_end,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        account_id,
        department,
        description as contact_description,
        email,
        first_name,
        home_phone,
        individual_id,
        is_deleted,
        cast(last_activity_date as {{ dbt.type_timestamp() }}) as last_activity_date,
        last_modified_by_id,
        last_modified_date,
        last_name,
        last_referenced_date,
        cast(last_viewed_date as {{ dbt.type_timestamp() }}) as last_viewed_date,
        lead_source,
        mailing_city,
        mailing_country,
        mailing_country_code,
        mailing_postal_code,
        mailing_state, 
        mailing_street,
        master_record_id,
        mobile_phone,
        name as contact_name,
        owner_id,
        phone,
        reports_to_id,
        title
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__contact_history_pass_through_columns') }}
        
    from fields
)

select *
from final
where not coalesce(is_deleted, false)