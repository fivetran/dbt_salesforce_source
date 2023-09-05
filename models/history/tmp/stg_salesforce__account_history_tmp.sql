select *
from {{ var('account_history') }}
-- {% if var('using_account_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
-- {% endif %}