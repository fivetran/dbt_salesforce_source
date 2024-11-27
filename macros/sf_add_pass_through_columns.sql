{% macro sf_add_pass_through_columns(base_columns, pass_through_var) %}

  {% if pass_through_var %}    
    {% for column in pass_through_var %}

      {% if column is mapping %}
        {% do column.update({"datatype": column.datatype if column.datatype else dbt.type_string()}) %}
        {% do base_columns.append(column) %}

      {% else %}
        {% do base_columns.append({ "name": column, "datatype": dbt.type_string()}) %}
      {% endif %}
    {% endfor %}
  {% endif %}

{% endmacro %}