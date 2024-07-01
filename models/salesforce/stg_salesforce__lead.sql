--To disable this model, set the salesforce__lead_enabled within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__lead_enabled', True)) }}

with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','lead')),
                staging_columns=get_lead_columns()
            )
        }}
        
    from {{ source('salesforce','lead') }}
), 

final as (
    
    select 
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        id as lead_id,
        {{ coalesce_w_renamed_col('annual_revenue', datatype=dbt.type_float()) }},
        city,
        company,
        {{ coalesce_w_renamed_col('converted_account_id') }},
        {{ coalesce_w_renamed_col('converted_contact_id') }},
        {{ coalesce_w_renamed_col('converted_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('converted_opportunity_id') }},
        country,
        {{ coalesce_w_renamed_col('country_code') }},
        {{ coalesce_w_renamed_col('created_by_id') }},
        {{ coalesce_w_renamed_col('created_date', datatype=dbt.type_timestamp()) }},
        description as lead_description,
        email,
        {{ coalesce_w_renamed_col('email_bounced_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('email_bounced_reason') }},
        {{ coalesce_w_renamed_col('first_name') }},
        {{ coalesce_w_renamed_col('has_opted_out_of_email', datatype=dbt.type_boolean()) }},
        {{ coalesce_w_renamed_col('individual_id') }},
        industry,
        {{ coalesce_w_renamed_col('is_converted', datatype=dbt.type_boolean()) }},
        {{ coalesce_w_renamed_col('is_deleted', datatype=dbt.type_boolean()) }},
        {{ coalesce_w_renamed_col('is_unread_by_owner', datatype=dbt.type_boolean()) }},
        {{ coalesce_w_renamed_col('last_activity_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_modified_by_id') }},
        {{ coalesce_w_renamed_col('last_modified_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_name') }},
        {{ coalesce_w_renamed_col('last_referenced_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_viewed_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('lead_source') }},
        {{ coalesce_w_renamed_col('master_record_id') }},
        {{ coalesce_w_renamed_col('mobile_phone') }},
        name as lead_name,
        {{ coalesce_w_renamed_col('number_of_employees', datatype=dbt.type_int()) }},
        {{ coalesce_w_renamed_col('owner_id') }},
        phone,
        {{ coalesce_w_renamed_col('postal_code') }},
        state,
        {{ coalesce_w_renamed_col('state_code') }},
        status,
        street,
        title,
        website
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__lead_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)