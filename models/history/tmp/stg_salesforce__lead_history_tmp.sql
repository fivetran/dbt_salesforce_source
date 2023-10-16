{{ config(enabled=var('salesforce__lead_history_enabled', False)) }}

select * 
from {{ var('lead_history') }}

{% if var('lead_first_date_var',[]) %}
where _fivetran_start >= '{{ var('lead_first_date_var') }}'
{% endif %}