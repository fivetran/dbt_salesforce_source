select *
from {{ var('user_role') }}
{%- if var('using_user_role_history_mode', false) -%}
where _fivetran_active
{%- endif -%}