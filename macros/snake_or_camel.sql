{%- macro snake_or_camel(table_name) -%}
    {{ return(adapter.dispatch('snake_or_camel', 'salesforce_source')(table_name)) }}
{% endmacro %}

{% macro default__snake_or_camel(table_name) %}
    {%- if execute -%}

        {%- set source_relation = adapter.get_relation(
            database=source('salesforce', table_name).database,
            schema=source('salesforce', table_name).schema,
            identifier=source('salesforce', table_name).name) -%}

        {{ return(table_name | replace('_', '') if source_relation is none else table_name) }}

    {% else %}
    {{ return(table_name) }}

    {%- endif -%} 
{% endmacro %}