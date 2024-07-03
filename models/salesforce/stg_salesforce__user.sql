{% set column_list = get_user_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','user')),
                staging_columns=column_list
            )
        }}

    from {{ source('salesforce','user') }}
), 

final as (
    
    select 
        _fivetran_deleted,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("account_id", column_dict ) }},
        {{ coalesce_rename("alias", column_dict ) }},
        {{ coalesce_rename("city", column_dict ) }},
        {{ coalesce_rename("company_name", column_dict ) }},
        {{ coalesce_rename("contact_id", column_dict ) }},
        {{ coalesce_rename("country", column_dict ) }},
        {{ coalesce_rename("country_code", column_dict ) }},
        {{ coalesce_rename("department", column_dict ) }},
        {{ coalesce_rename("email", column_dict ) }},
        {{ coalesce_rename("first_name", column_dict ) }},
        {{ coalesce_rename("id", column_dict, alias="user_id" ) }},
        {{ coalesce_rename("individual_id", column_dict ) }},
        {{ coalesce_rename("is_active", column_dict ) }},
        {{ coalesce_rename("last_login_date", column_dict ) }},
        {{ coalesce_rename("last_name", column_dict ) }},
        {{ coalesce_rename("last_referenced_date", column_dict ) }},
        {{ coalesce_rename("last_viewed_date", column_dict ) }},
        {{ coalesce_rename("manager_id", column_dict ) }},
        {{ coalesce_rename("name", column_dict, alias="user_name" ) }},
        {{ coalesce_rename("postal_code", column_dict ) }},
        {{ coalesce_rename("profile_id", column_dict ) }},
        {{ coalesce_rename("state", column_dict ) }},
        {{ coalesce_rename("state_code", column_dict ) }},
        {{ coalesce_rename("street", column_dict ) }},
        {{ coalesce_rename("title", column_dict ) }},
        {{ coalesce_rename("user_role_id", column_dict ) }},
        {{ coalesce_rename("user_type", column_dict ) }},
        {{ coalesce_rename("username", column_dict ) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__user_pass_through_columns') }}
    
    from fields
    where coalesce(_fivetran_active, true)
)

select * 
from final