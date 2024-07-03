{% macro coalesce_rename(
    column_key,
    column_dict,
    original_column_name=column_dict[column_key]["name"],
    datatype=column_dict[column_key]["datatype"],
    alias=column_dict[column_key]["alias"] | default(original_column_name),
    renamed_column_name=column_dict[column_key]["renamed_column_name"]
    ) %}

{# This macro accomodates Fivetran connectors that keep the original salesforce field naming conventions without underscores #}
{%- if original_column_name|lower == renamed_column_name|lower %}
    cast({{ renamed_column_name }} as {{ datatype }}) as {{ alias }}

{%- else %}
    coalesce(cast({{ renamed_column_name }} as {{ datatype }}),
        cast({{ original_column_name }} as {{ datatype }}))
        as {{ alias }}

{%- endif %}
{%- endmacro %}