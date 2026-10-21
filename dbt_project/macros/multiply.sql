{% macro multiply(x,y,prec = 0)%}
  round(({{ x }})*({{ y }}), {{ prec }})
{% endmacro %}