
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
    from base
),

final as (
    
    select 
        _fivetran_synced,
        annual_revenue,
        city,
        company,
        converted_account_id,
        converted_contact_id,
        converted_date,
        converted_opportunity_id,
        country,
        country_code,
        created_by_id,
        created_date,
        description,
        email,
        email_bounced_date,
        email_bounced_reason,
        fax,
        first_name,
        geocode_accuracy,
        has_opted_out_of_email,
        id,
        individual_id,
        industry,
        is_converted,
        is_deleted,
        is_unread_by_owner,
        jigsaw_contact_id,
        last_activity_date,
        last_modified_by_id,
        last_modified_date,
        last_name,
        last_referenced_date,
        last_viewed_date,
        latitude,
        lead_source,
        longitude,
        master_record_id,
        mobile_phone,
        name,
        number_of_employees,
        owner_id,
        phone,
        photo_url,
        postal_code,
        salutation,
        state,
        state_code,
        status,
        street,
        system_modstamp,
        title,
        website
    from fields
)

select *
from final
