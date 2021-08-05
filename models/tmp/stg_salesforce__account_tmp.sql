select *
from {{ var('account') }}
{%- if var('salesforce__using_history_mode', false) -%}
where _fivetran_active
{%- endif -%}