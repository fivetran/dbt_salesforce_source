with source as (

    select 
        *
    from {{ ref('stg_salesforce__account_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce__account_tmp')),
                staging_columns=get_account_columns()
            )
        }}

        {% if var('account_pass_through_columns') != [] %}
        ,
        {{ var('account_pass_through_columns') | join (", ")}}

        {% endif %}
        

    from source

)
select * 
from renamed
where not is_deleted