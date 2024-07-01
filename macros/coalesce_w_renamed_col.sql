{% macro coalesce_w_renamed_col(original_column_name, datatype=dbt.type_string()) %}
{# This macro accomodates Fivetran connectors that keep the original salesforce field naming conventions without underscores #}

{%- set renamed_col = original_column_name.replace('_', '') -%}

coalesce(cast({{ renamed_col }} as {{ datatype }}),
    cast({{ original_column_name }} as {{ datatype }}))
    as {{ original_column_name }}

{%- endmacro %}