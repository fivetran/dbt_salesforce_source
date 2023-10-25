--To disable this model, set the below variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__opportunity_line_item_enabled', True)) }}

select * 
{% if var('using_salesforce_history_mode_only', false) %}
from {{ var('opportunity_line_item')}}
{% if var('using_opportunity_line_items_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
{% else %}
from {{ var('opportunity_line_item_history')}}
where coalesce(_fivetran_active, true)
{% endif %}