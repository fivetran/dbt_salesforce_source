{%- macro original_or_rename(source_name, table_name) -%}
    {{ return(adapter.dispatch('original_or_rename', 'salesforce_source')(source_name, table_name)) }}
{% endmacro %}

{% macro default__original_or_rename(source_name, table_name) %}
    {%- if execute -%}

        {%- set source_relation = adapter.get_relation(
            database=source(source_name, table_name).database,
            schema=source(source_name, table_name).schema,
            identifier=table_name) -%}

        {{ return(table_name if source_relation else table_name  ~ '_no_rename' ) }}

    {% else %}
    {{ return(table_name) }}

    {%- endif -%} 
{% endmacro %}