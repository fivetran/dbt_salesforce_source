select * 
from {{ var('contact') }}
{% if var('using_contact_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
