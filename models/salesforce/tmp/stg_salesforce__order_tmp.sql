--To disable this model, set the below variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__order_enabled', True)) }}

select * 
{% if var('using_salesforce_history_mode_only', false) %}
from {{ var('order')}}
{% if var('using_order_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
{% else %}
from {{ var('order_history')}}
where coalesce(_fivetran_active, true)
{% endif %}
