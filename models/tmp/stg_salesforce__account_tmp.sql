select *
from {{ var('account') }}
{% if var('using_account_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}