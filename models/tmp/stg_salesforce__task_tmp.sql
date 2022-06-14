select * 
from {{ var('task') }}
{% if var('using_task_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
