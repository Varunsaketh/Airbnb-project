{% macro replace(string) %}
    REPLACE({{ string }}, ' ', '_')
{%endmacro%}