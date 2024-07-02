--To disable this model, set the salesforce__user_role_enabled within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__user_role_enabled', True)) }}

{% set column_list = get_user_role_columns() -%}
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
        {{ salesforce_source.build_staging_columns(column_list) }}
        {{ fivetran_utils.fill_pass_through_columns('salesforce__user_role_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final