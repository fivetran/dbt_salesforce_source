select * 
from {{ var('opportunity_history') }}
{% if var('using_lead_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
