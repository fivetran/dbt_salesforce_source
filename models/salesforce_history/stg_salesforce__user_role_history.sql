{{ config(enabled=var('salesforce__user_role_history_enabled', False)) }}

with base as (

    select *
    from {{ ref('stg_salesforce__user_role_history_tmp') }}
), 

fields as (

    select
        
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__user_role_history_tmp')),
                staging_columns=get_user_role_history_columns()
            )
        }}

    from base
), 

final as (

    select
        id as user_role_id,
        _fivetran_active,        
        cast(_fivetran_start as {{ dbt.type_timestamp() }}) as _fivetran_start,
        cast(_fivetran_end as {{ dbt.type_timestamp() }}) as _fivetran_end,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        developer_name,
        name as user_role_name,
        opportunity_access_for_account_owner,
        parent_role_id,
        rollup_description
        
        {{ fivetran_utils.fill_pass_through_columns('salesforce__user_role_history_pass_through_columns') }}
        
    from fields
)

select *
from final