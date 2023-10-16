{{ config(enabled=var('salesforce__account_history_enabled', False)) }}

select *
from {{ var('account_history') }}

{% if var('account_first_date_var',[]) %}
where _fivetran_start >= '{{ var('account_first_date_var') }}'
{% endif %}     