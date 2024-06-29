{% macro coalesce_w_renamed_col(original_column_name, datatype=none) %}
{# This macro accomodates Fivetran connectors that keep the original salesforce field naming conventions without underscores #}
{%- set renamed_col = original_column_name.replace('_', '') -%}

{% if datatype is none -%}
coalesce({{ renamed_col }}, {{ original_column_name }})
{% else -%}
coalesce(cast({{ renamed_col }} as {{ datatype }}),
    cast({{ original_column_name }} as {{ datatype }}))
{% endif -%}
as {{ original_column_name }}

{%- endmacro %}