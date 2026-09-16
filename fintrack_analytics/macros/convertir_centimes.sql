{% macro convertir_centimes(column_name) %}
    CAST({{ column_name }} AS NUMERIC) * 100.0
{% endmacro %}