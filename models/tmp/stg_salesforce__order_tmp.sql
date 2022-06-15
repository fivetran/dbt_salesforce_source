select *
from {{ var('order') }}
{% if var('using_order_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
