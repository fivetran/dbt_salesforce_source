select * 
{% if var('using_salesforce_history_mode_only', false) %}
from {{ var('opportunity')}}
{% if var('using_opportunity_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
{% else %}
from {{ var('opportunity_history')}}
where coalesce(_fivetran_active, true)
{% endif %}