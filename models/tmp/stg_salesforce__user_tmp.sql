select *
from {{ var('user') }}
{%- if var('using_user_history_mode', false) -%}
where _fivetran_active
{%- endif -%}