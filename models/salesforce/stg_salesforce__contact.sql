
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
        {{ coalesce_w_renamed_col('account_id') }},
        department,
        description as contact_description,
        email,
        {{ coalesce_w_renamed_col('first_name') }},
        {{ coalesce_w_renamed_col('home_phone') }},
        {{ coalesce_w_renamed_col('individual_id') }},
        {{ coalesce_w_renamed_col('is_deleted') }},
        {{ coalesce_w_renamed_col('last_activity_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_modified_by_id') }},
        {{ coalesce_w_renamed_col('last_modified_date') }},
        {{ coalesce_w_renamed_col('last_name') }},
        {{ coalesce_w_renamed_col('last_referenced_date') }},
        {{ coalesce_w_renamed_col('last_viewed_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('lead_source') }},
        {{ coalesce_w_renamed_col('mailing_city') }},
        {{ coalesce_w_renamed_col('mailing_country') }},
        {{ coalesce_w_renamed_col('mailing_country_code') }},
        {{ coalesce_w_renamed_col('mailing_postal_code') }},
        {{ coalesce_w_renamed_col('mailing_state') }},
        {{ coalesce_w_renamed_col('mailing_state_code') }},
        {{ coalesce_w_renamed_col('mailing_street') }},
        {{ coalesce_w_renamed_col('master_record_id') }},
        {{ coalesce_w_renamed_col('mobile_phone') }},
        name as contact_name,
        {{ coalesce_w_renamed_col('owner_id') }},
        phone,
        {{ coalesce_w_renamed_col('reports_to_id') }},
        title
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__contact_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)