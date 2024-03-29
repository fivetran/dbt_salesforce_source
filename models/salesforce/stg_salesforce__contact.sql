
with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','contact')),
                staging_columns=get_contact_columns()
            )
        }}
        
    from {{ source('salesforce','contact') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        id as contact_id,
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
        mailing_state_code,
        mailing_street,
        master_record_id,
        mobile_phone,
        name as contact_name,
        owner_id,
        phone,
        reports_to_id,
        title
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__contact_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)