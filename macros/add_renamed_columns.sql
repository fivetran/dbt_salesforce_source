{% macro add_renamed_columns(column_list) %}

{%- set renamed_columns = [] %}

{%- for col in column_list %}
    {# Use the alias if it is provided. #}
    {%- set original_column_name = col.name %}

    {%- if 'fivetran' not in original_column_name %}
        {# Use renamed_column_name value if it provided in the get_columns macro #}
        {%- set renamed_column_name = col.renamed_column_name 
            | default(original_column_name.split('_') | map('capitalize') | join('')) %}

        {# Add an entry to the list of renames to populate the filled columns if the rename is different #}
        {% if renamed_column_name|lower != original_column_name|lower %}
            {%- do renamed_columns.append({"name": renamed_column_name, "datatype": col.datatype, "is_rename": true}) %}
        {%- endif %}

        {# Update the original column with the renamed column name for use later. #}
        {%- set col = col.update({ "renamed_column_name": renamed_column_name, "is_rename": false}) %}
    {%- endif %}
{%- endfor %}

{%- do column_list.extend(renamed_columns) %}

{% endmacro %}
