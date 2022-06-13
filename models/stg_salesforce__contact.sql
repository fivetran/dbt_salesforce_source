
with base as (

    select * 
    from {{ ref('stg_salesforce__contact_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__contact_tmp')),
                staging_columns=get_contact_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        account_id,
        assistant_name,
        assistant_phone,
        birthdate,
        department,
        description,
        do_not_call,
        email,
        email_bounced_date,
        email_bounced_reason,
        fax,
        first_name,
        has_opted_out_of_email,
        has_opted_out_of_fax,
        home_phone,
        id,
        individual_id,
        is_deleted,
        is_email_bounced,
        jigsaw,
        jigsaw_contact_id,
        last_activity_date,
        last_curequest_date,
        last_cuupdate_date,
        last_modified_by_id,
        last_modified_date,
        last_name,
        last_referenced_date,
        last_viewed_date,
        lead_source,
        mailing_city,
        mailing_country,
        mailing_country_code,
        mailing_geocode_accuracy,
        mailing_latitude,
        mailing_longitude,
        mailing_postal_code,
        mailing_state,
        mailing_state_code,
        mailing_street,
        master_record_id,
        mobile_phone,
        name,
        other_city,
        other_country,
        other_geocode_accuracy,
        other_latitude,
        other_longitude,
        other_phone,
        other_postal_code,
        other_state,
        other_street,
        owner_id,
        phone,
        photo_url,
        reports_to_id,
        salutation,
        system_modstamp,
        title
    from fields
)

select *
from final
