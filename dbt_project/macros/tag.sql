{% macro tag(s) %}
    CASE
        WHEN CAST({{ s }} as int) < 100 THEN 'low'
        WHEN CAST({{ s }} as int) < 200 THEN 'medium'
        ELSE 'high'
    END
{% endmacro %}