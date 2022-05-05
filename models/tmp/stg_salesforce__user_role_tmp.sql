--To disable this model, set the using_user_role variable within your dbt_project.yml file to False.
{{ config(enabled=var('salesforce__user_role_enabled', True)) }}

select *
from {{ var('user_role') }}
{% if var('using_user_role_history_mode_active_records', false) %}
{%- if target.type == 'snowflake' %}
where coalesce("_FIVETRAN_ACTIVE", true)
{% else %}
where coalesce(_fivetran_active, true)
{% endif %}
{% endif %}