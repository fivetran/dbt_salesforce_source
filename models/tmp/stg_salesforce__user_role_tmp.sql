select *
from {{ var('user_role') }}
{%- if var('salesforce__using_history_mode', false) -%}
where _fivetran_active
{%- endif -%}