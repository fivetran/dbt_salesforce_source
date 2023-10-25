select * 
{% if var('using_salesforce_history_mode_only', false) %}
from {{ var('contact') }}
{% if var('using_contact_history_mode_active_records', false) %}
where coalesce(_fivetran_active, true)
{% endif %}
{% else %}
from {{ var('contact_history')}}
where coalesce(_fivetran_active, true) 
{% endif %}
