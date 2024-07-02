{{ config(
    tags="fivetran_validations",
    enabled=var('fivetran_validation_tests_enabled', false)
) }}

-- this test is to make sure the final columns are the same between versions
with prod as (
    select *
    from {{ ref('stg_salesforce__contact') }}
),

dev as (
    select *
    from {{ ref('stg_salesforce__contact') }}
),

final as (
    -- test will fail if any rows from prod are not found in dev
    (select * from prod
    except distinct
    select * from dev)

    union all -- union since we only care if rows are produced

    -- test will fail if any rows from dev are not found in prod
    (select * from dev
    except distinct
    select * from prod)
)

select *
from final