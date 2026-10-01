{%set incremental_flag = 1 %}
{% set incremental_col = 'CREATED_AT'%}
SELECT * FROM {{ source('staging', 'bookings') }}
{%if incremental_flag == 1%}
WHERE {{incremental_col}} > (SELECT coalesce(max({{incremental_col}}), '1900-01-01') FROM {{ ref("b_bookings") }})
{%endif%}
