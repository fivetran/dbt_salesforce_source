select *
{% if var('using_salesforce_history_mode_only', true) %}
from {{ var('user_history')}}
where coalesce(_fivetran_active, true)
{% else %}
from {{ var('user_role') }}
{% endif %}
{% if var('using_user_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}