{% macro trim(s)%}
  upper(trim({{ s }}))
{%endmacro%}