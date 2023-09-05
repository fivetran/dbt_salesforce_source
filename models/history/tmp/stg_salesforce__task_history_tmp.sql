select * 
from {{ var('task_history') }}
{% if var('using_task_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}