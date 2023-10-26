{{ config(
        enabled=var('salesforce__contact_history_enabled', False),
        materialized='incremental',
        unique_key='history_unique_key',
        incremental_strategy='insert_overwrite' if target.type in ('bigquery', 'spark', 'databricks') else 'delete+insert',
        partition_by={
            "field": "_fivetran_date", 
            "data_type": "date"
        } if target.type not in ('spark','databricks') else ['_fivetran_date'],
        file_format='parquet',
        on_schema_change='fail'
    ) 
}}

with base as (

    select *      
    from {{ source('salesforce_history', 'contact') }}
    {% if is_incremental() %}
    where _fivetran_start >=  (select max(cast((_fivetran_start) as {{ dbt.type_timestamp() }})) from {{ this }} )
    {% else %}
    {% if var('global_history_start_date',[]) or var('contact_history_start_date',[]) %}
    where _fivetran_start >= 
        {% if var('contact_history_start_date', []) %}
            "{{ var('contact_history_start_date') }}"
        {% else %}
            "{{ var('global_history_start_date') }}"
        {% endif %}
    {% endif %}
    {% endif %} 
),

final as (

    select 
        id as contact_id,
        cast(_fivetran_start as {{ dbt.type_timestamp() }}) as _fivetran_start,
        cast(_fivetran_end as {{ dbt.type_timestamp() }}) as _fivetran_end,
        cast(_fivetran_start as date) as _fivetran_date,
        {{ dbt_utils.generate_surrogate_key(['id', '_fivetran_start']) }} as history_unique_key,

        {{ dbt_utils.star(from=source('salesforce_history','contact'),
                        except=["id", "_fivetran_start", "_fivetran_end"]) }}
    from base
)

select *
from final