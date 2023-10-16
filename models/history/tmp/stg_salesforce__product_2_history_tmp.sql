{{ config(enabled=var('salesforce__product_2_history_enabled', False)) }}

select * 
from {{ var('product_2_history') }}

{% if var('product_2_first_date_var',[]) %}
where _fivetran_start >= '{{ var('product_2_first_date_var') }}'
{% endif %}