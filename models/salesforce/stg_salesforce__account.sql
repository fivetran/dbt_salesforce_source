{% set column_list = get_account_columns() -%}
with fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(source('salesforce','account')),
                staging_columns=column_list
            )
        }}

    from {{ source('salesforce','account') }}
), 

final as (
    select
        {{ salesforce_source.build_staging_columns(column_list) }}
        {{ fivetran_utils.fill_pass_through_columns('salesforce__account_pass_through_columns') }}

    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
where not coalesce(is_deleted, false)