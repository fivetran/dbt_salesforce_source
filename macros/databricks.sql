{% macro databricks__datediff(first_date, second_date, datepart) %}

    DATEDIFF(
        cast({{second_date}} as datetime),
        cast({{first_date}} as datetime),
    )

{% endmacro %}
