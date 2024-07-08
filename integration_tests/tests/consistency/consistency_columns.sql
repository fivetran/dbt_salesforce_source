{{ config(
    tags="fivetran_validations",
    enabled=var('fivetran_validation_tests_enabled', false)
) }}

-- this test is to make sure the final columns are the same between versions
-- ONLY RUNS IN BIGQUERY!
with prod as (
    select
        table_name,
        column_name,
        case when lower(data_type) like '%numeric%' then 'numeric'
            else data_type 
            end as data_type
    from {{ target.schema }}_salesforce_source_prod.INFORMATION_SCHEMA.COLUMNS
),

dev as (
    select
        table_name,
        column_name,
        case when lower(data_type) like '%numeric%' then 'numeric'
            else data_type 
            end as data_type
    from {{ target.schema }}_salesforce_source_dev.INFORMATION_SCHEMA.COLUMNS
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