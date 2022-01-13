{% macro databricks__datediff(first_date, second_date, datepart) %}

    DATEDIFF(
        cast({{second_date}} as date),
        cast({{first_date}} as date)
    )

{% endmacro %}
