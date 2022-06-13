select * 
from {{ var('opportunity_line_item') }}
{% if var('using_opportunity_line_item_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
