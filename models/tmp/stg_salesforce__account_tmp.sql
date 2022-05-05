select *
from {{ var('account') }}
{% if var('using_account_history_mode_active_records', false) %}
where 
    {% if target.type == 'snowflake' %}
        coalesce("_FIVETRAN_ACTIVE", true)
    {% endif %}

    coalesce(_fivetran_active, true)
{% endif %}