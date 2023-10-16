{{ config(enabled=var('salesforce__contact_history_enabled', False)) }}

select * 
from {{ var('contact_history') }}

{% if var('contact_first_date_var',[]) %}
where _fivetran_start >= '{{ var('contact_first_date_var') }}'
{% endif %}