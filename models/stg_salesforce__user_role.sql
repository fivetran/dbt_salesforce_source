with source as (

    select *
    from {{ ref('stg_salesforce__user_role_tmp') }}

), macro as (

    select
        /*
        The below macro is used to generate the correct SQL for package staging models. It takes a list of columns 
        that are expected/needed (staging_columns from dbt_salesforce_source/models/tmp/) and compares it with columns 
        in the source (source_columns from dbt_salesforce_source/macros/).

        For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
        */
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__user_role_tmp')),
                staging_columns=get_user_role_columns()
            )
        }}

    from source

), renamed as (

  select
    _fivetran_deleted,
    _fivetran_synced,
    developer_name,
    id as user_role_id,
    name as user_role_name,
    opportunity_access_for_account_owner,
    parent_role_id,
    rollup_description
  from macro

)

select *
from renamed
where not coalesce(_fivetran_deleted, false)