select *
{% if var('using_salesforce_history_mode_only', true) %}
from {{ var('opportunity_history')}}
where coalesce(_fivetran_active, true)
{% else %}
from {{ var('opportunity') }}
{% endif %}
{% if var('using_opportunity_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}