--To disable this model, set the below variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__user_role_enabled', True)) }}

select *
from {{ var('user_role') }}
{% if var('using_user_role_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}