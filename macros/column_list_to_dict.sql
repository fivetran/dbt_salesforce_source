{% macro column_list_to_dict(column_list) %}

    {%- set column_dict = {} -%}
    {%- for col in column_list -%}
        {%- do column_dict.update({col.name: col}) if not col.is_rename -%}
    {%- endfor -%}
    {{ return(column_dict) }}

{% endmacro %}