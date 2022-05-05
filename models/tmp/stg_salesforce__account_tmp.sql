select *
from {{ var('account') }}
{% if var('using_opportunity_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}