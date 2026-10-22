{% macro response_tag(response_rate) %}
    CASE
        WHEN {{ response_rate }} >= 100 THEN 'High'
        ELSE 'Low'
    END
{% endmacro %}