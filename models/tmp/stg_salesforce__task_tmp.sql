--To disable this model, set the below variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__task_role_enabled', True)) }}

select * 
from {{ var('task') }}
{% if var('using_task_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
