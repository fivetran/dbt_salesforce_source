{{ config(enabled=var('salesforce__opportunity_history_enabled', False)) }}

select * 
from {{ var('opportunity_history') }}

{% if var('opportunity_first_date_var',[]) %}
where _fivetran_start >= '{{ var('opportunity_first_date_var') }}'
{% endif %}