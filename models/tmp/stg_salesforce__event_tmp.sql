select * 
from {{ var('event') }}
{% if var('using_event_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
