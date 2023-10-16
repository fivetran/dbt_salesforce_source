{{ config(enabled=var('salesforce__event_history_enabled', False)) }}

select * 
from {{ var('event_history') }}

{% if var('event_first_date_var',[]) %}
where _fivetran_start >= '{{ var('event_first_date_var') }}'
{% endif %}