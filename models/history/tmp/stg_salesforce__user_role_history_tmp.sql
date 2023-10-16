{{ config(enabled=var('salesforce__user_role_history_enabled', False)) }}

select * 
from {{ var('user_role_history') }}

{% if var('user_role_first_date_var',[]) %}
where _fivetran_start >= '{{ var('user_role_first_date_var') }}'
{% endif %}