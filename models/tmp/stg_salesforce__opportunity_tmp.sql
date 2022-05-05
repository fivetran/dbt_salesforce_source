select *
from {{ var('opportunity') }}
{% if var('using_opportunity_history_mode_active_records', false) %}
{%- if target.type == 'snowflake' %}
where coalesce("_FIVETRAN_ACTIVE", true)
{% else %}
where coalesce(_fivetran_active, true)
{% endif %}
{% endif %}