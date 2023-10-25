select * 
{% if var('using_salesforce_history_mode_only', false) %}
from {{ var('user')}}
{% if var('using_user_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
{% else %}
from {{ var('user_history')}}
where coalesce(_fivetran_active, true)
{% endif %}