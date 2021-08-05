select *
from {{ var('account') }}
{%- if var('using_account_history_mode', false) -%}
where _fivetran_active
{%- endif -%}