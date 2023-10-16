{{ config(enabled=var('salesforce__opportunity_line_item_history_enabled', False)) }}

select * 
from {{ var('opportunity_line_item_history') }}

{% if var('opportunity_line_item_first_date_var',[]) %}
where _fivetran_start >= '{{ var('opportunity_line_item_first_date_var') }}'
{% endif %}