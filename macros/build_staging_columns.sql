{% macro build_staging_columns(column_list) %}
{# This macro accomodates Fivetran connectors that keep the original salesforce field naming conventions without underscores #}

{%- for col in column_list %}
    {# Use the alias if it is provided. #}
    {% set final_column_name = col.alias | default(col.name) %}

    {%- if col.renamed_column_name %}
        {{- ',' if not loop.first }}
        coalesce(cast({{ col.renamed_column_name }} as {{ col.datatype }}),
            cast({{ final_column_name }} as {{ col.datatype }}))
            as {{ final_column_name }}
        

    {%- elif not col.is_rename and not col.exclude_from_final %}
        {{- ',' if not loop.last }}
        cast({{ final_column_name }} as {{ col.datatype }})
            as {{ final_column_name }}
    {%- endif %}
{%- endfor %}

{% endmacro %}