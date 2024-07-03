--To disable this model, set the salesforce__user_role_enabled within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__user_role_enabled', True)) }}

{% set column_list = get_user_role_columns() -%}
{% set column_dict = column_list_to_dict(column_list) -%}

with fields as (

    select
        
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','user_role')),
                staging_columns=column_list
            )
        }}

    from {{ source('salesforce','user_role') }}
), 

final as (

    select
        _fivetran_deleted,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_rename("developer_name", column_dict ) }},
        {{ coalesce_rename("id", column_dict, alias="user_role_id") }},
        {{ coalesce_rename("name", column_dict, alias="user_role_name") }},
        {{ coalesce_rename("opportunity_access_for_account_owner", column_dict ) }},
        {{ coalesce_rename("parent_role_id", column_dict ) }},
        {{ coalesce_rename("rollup_description", column_dict ) }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__user_role_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final