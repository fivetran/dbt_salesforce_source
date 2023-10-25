--To disable this model, set the below variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__product_2_enabled', True)) }}

select * 
{% if var('using_salesforce_history_mode_only', true) %}
from {{ var('product_2_history')}}
where coalesce(is_active, true)
{% else %}
from {{ var('product_2') }}
{% endif %}
{% if var('using_product_2_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}