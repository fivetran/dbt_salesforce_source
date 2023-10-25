select *
{% if var('using_salesforce_history_mode_only', false) %}
from {{ var('account') }}
{% if var('using_account_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
{% else %}
from {{ var('account_history')}}
where coalesce(_fivetran_active, true)
{% endif %}