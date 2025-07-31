{%- macro check_for_rename(table_name) -%}
    {{ return(adapter.dispatch('check_for_rename', 'salesforce_source')(table_name)) }}
{% endmacro %}

{% macro default__check_for_rename(table_name) %}
    {%- if execute -%}

        {%- set source_relation = adapter.get_relation(
            database=source('salesforce', table_name).database,
            schema=source('salesforce', table_name).schema,
            identifier=source('salesforce', table_name).name) -%}

        {{ return(table_name if source_relation else table_name  ~ '_no_rename' ) }}

    {% else %}
    {{ return(table_name) }}

    {%- endif -%} 
{% endmacro %}