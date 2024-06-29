
with fields as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','user')),
                staging_columns=get_user_columns()
            )
        }}

    from {{ source('salesforce','user') }}
), 

final as (
    
    select 
        _fivetran_deleted,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_w_renamed_col('account_id') }},
        alias,
        city,
        {{ coalesce_w_renamed_col('company_name') }},
        {{ coalesce_w_renamed_col('contact_id') }},
        country,
        {{ coalesce_w_renamed_col('country_code') }},
        department,
        email,
        {{ coalesce_w_renamed_col('first_name') }},
        id as user_id,
        {{ coalesce_w_renamed_col('individual_id') }},
        {{ coalesce_w_renamed_col('is_active') }},
        {{ coalesce_w_renamed_col('last_login_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_name') }},
        {{ coalesce_w_renamed_col('last_referenced_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('last_viewed_date', datatype=dbt.type_timestamp()) }},
        {{ coalesce_w_renamed_col('manager_id') }},
        name as user_name,
        {{ coalesce_w_renamed_col('postal_code') }},
        {{ coalesce_w_renamed_col('profile_id') }},
        state,
        {{ coalesce_w_renamed_col('state_code') }},
        street,
        title,
        {{ coalesce_w_renamed_col('user_role_id') }},
        {{ coalesce_w_renamed_col('user_type') }},
        username 
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__user_pass_through_columns') }}
    
    from fields
    where coalesce(_fivetran_active, true)
)

select * 
from final