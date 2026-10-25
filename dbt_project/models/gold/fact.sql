{% set configs = [
    {
        "table": "AIRBNB.GOLD.OBT",
        "columns": "GOLD_OBT.BOOKING_ID, GOLD_OBT.LISTING_ID, GOLD_OBT.TOTAL_AMOUNT, GOLD_OBT.HOST_ID, GOLD_OBT.PRICE_PER_NIGHT, GOLD_OBT.RESPONSE_RATE",
        "alias": "GOLD_OBT"
    },
    {
        "table": "AIRBNB.GOLD.DIM_LISTINGS",
        "columns": "DIM_LISTINGS.PROPERTY_TYPE, DIM_LISTINGS.ROOM_TYPE, DIM_LISTINGS.CITY, DIM_LISTINGS.COUNTRY",
        "alias": "DIM_LISTINGS",
        "join_condition": "GOLD_OBT.LISTING_ID = DIM_LISTINGS.LISTING_ID"
    },
    {
        "table": "AIRBNB.GOLD.DIM_HOSTS",
        "columns": "DIM_HOSTS.HOST_NAME, DIM_HOSTS.IS_SUPER_HOST",
        "alias": "DIM_HOSTS",
        "join_condition": "GOLD_OBT.HOST_ID = DIM_HOSTS.HOST_ID"
    }
] %}

SELECT
    {% for c in configs %}
        {{ c.columns }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM {{ configs[0].table }} AS {{ configs[0].alias }}
{% for c in configs[1:] %}
    LEFT JOIN {{ c.table }} AS {{ c.alias }}
        ON {{ c.join_condition }}
{% endfor %}