{{ config(enabled=var('salesforce__user_history_enabled', False)) }}

select * 
from {{ var('user_history') }}

{% if var('user_first_date_var',[]) %}
where _fivetran_start >= '{{ var('user_first_date_var') }}'
{% endif %}