select *
from {{ var('opportunity') }}
{%- if var('using_opportunity_history_mode', false) -%}
where _fivetran_active
{%- endif -%}