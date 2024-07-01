{% macro coalesce_w_renamed_col(original_column_name, datatype=dbt.type_string(), alias=original_column_name, renamed_column_name=original_column_name.replace('_', '')) %}
{# This macro accomodates Fivetran connectors that keep the original salesforce field naming conventions without underscores #}

coalesce(cast({{ renamed_column_name }} as {{ datatype }}),
    cast({{ original_column_name }} as {{ datatype }}))
    as {{ alias }}

{%- endmacro %}