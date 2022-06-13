select * 
from {{ var('product_2') }}
{% if var('using_product_2_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
