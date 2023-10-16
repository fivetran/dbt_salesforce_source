{{ config(enabled=var('salesforce__task_history_enabled', False)) }}

select * 
from {{ var('task_history') }} 

{% if var('task_first_date_var',[]) %}
where _fivetran_start >= '{{ var('task_first_date_var') }}'
{% endif %}