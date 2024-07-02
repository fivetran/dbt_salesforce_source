--To disable this model, set the salesforce__task_enabled variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__task_enabled', True)) }}

{% set column_list = get_task_columns() -%}
with fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','task')),
                staging_columns=column_list
            )
        }}
        
    from {{ source('salesforce','task') }}
), 

final as (
    
    select 
        {{ salesforce_source.build_staging_columns(column_list) }}
        {{ fivetran_utils.fill_pass_through_columns('salesforce__task_pass_through_columns') }}
        
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)