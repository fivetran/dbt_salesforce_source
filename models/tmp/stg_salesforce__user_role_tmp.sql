select *
from {{ var('user_role') }}
{% if var('using_user_role_history_mode_active_records', false) %}
where coalesce(_fivetran_active, false)
{% endif %}