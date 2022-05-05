select *
from {{ var('opportunity') }}
{% if var('using_opportunity_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}