--To disable this model, set the salesforce__order_enabled within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__order_enabled', True)) }}

{% set column_list = get_order_columns() -%}
with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','order')),
                staging_columns=column_list
            )
        }}
        
    from {{ source('salesforce','order') }}
), 

final as (
    
    select 
        {{ salesforce_source.build_staging_columns(column_list) }}
        {{ fivetran_utils.fill_pass_through_columns('salesforce__order_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)