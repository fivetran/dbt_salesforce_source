--To disable this model, set the below variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__product_2_enabled', True)) }}

select * 
from {{ var('product_2') }}
{% if var('using_product_2_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
