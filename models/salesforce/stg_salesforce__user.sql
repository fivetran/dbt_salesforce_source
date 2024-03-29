
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
        cast(last_login_date as {{ dbt.type_timestamp() }}) as last_login_date,
        last_name,
        cast(last_referenced_date as {{ dbt.type_timestamp() }}) as last_referenced_date,
        cast(last_viewed_date as {{ dbt.type_timestamp() }}) as last_viewed_date,
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
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__user_pass_through_columns') }}
    
    from fields
    where coalesce(_fivetran_active, true)
)

select * 
from final