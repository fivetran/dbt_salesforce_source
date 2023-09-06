select * 
from {{ var('user_history') }}
{% if var('using_user_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}