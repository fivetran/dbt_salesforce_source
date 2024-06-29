--To disable this model, set the salesforce__user_role_enabled within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__user_role_enabled', True)) }}

with fields as (

    select
        
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','user_role')),
                staging_columns=get_user_role_columns()
            )
        }}

    from {{ source('salesforce','user_role') }}
), 

final as (

    select
        _fivetran_deleted,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        {{ coalesce_w_renamed_col('developer_name') }},
        id as user_role_id,
        name as user_role_name,
        {{ coalesce_w_renamed_col('opportunity_access_for_account_owner') }},
        {{ coalesce_w_renamed_col('parent_role_id') }},
        {{ coalesce_w_renamed_col('rollup_description') }}
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__user_role_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final