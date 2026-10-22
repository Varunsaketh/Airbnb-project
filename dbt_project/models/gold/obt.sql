{% set configs = [
    {
        "table": "AIRBNB.SILVER.s_bookings",
    "columns" : "s_bookings.BOOKING_ID,s_bookings.LISTING_ID,s_bookings.TOTAL_AMOUNT,s_bookings.booking_status,s_bookings.BOOKING_DATE,s_bookings.CREATED_AT AS BOOKING_CREATED_AT",
        "alias": "s_bookings"

    },
    {
        "table": "AIRBNB.SILVER.s_listings",
        "columns" : "s_listings.HOST_ID,s_listings.PROPERTY_TYPE,s_listings.ROOM_TYPE,s_listings.ACCOMODATES,s_listings.BATHROOMS,s_listings.BEDROOMS,s_listings.CITY,s_listings.COUNTRY,s_listings.PRICE_PER_NIGHT,s_listings.PRICE_TAG,s_listings.CREATED_AT AS LISTINGS_CREATED_AT",
        "alias": "s_listings",
        "join_condition": "s_bookings.listing_id = s_listings.listing_id"
    },
    {
        "table": "AIRBNB.SILVER.s_hosts",
        "columns" : "s_hosts.HOST_NAME,s_hosts.HOST_SINCE,s_hosts.RESPONSE_RATE,s_hosts.RESPONSE_TAG,s_hosts.IS_SUPER_HOST,s_hosts.CREATED_AT AS HOSTS_CREATED_AT",
        "alias": "s_hosts",
        "join_condition": "s_listings.host_id = s_hosts.host_id"
    }
]%}

SELECT
    {% for c in configs %}
        {{ c.columns }}{% if not loop.last %},{% endif%}
    {%endfor%}
FROM
{{configs[0].table}} AS {{configs[0].alias}}
{%for c in configs[1:]%}
    LEFT JOIN {{c.table}} AS {{c.alias}}
    ON {{c.join_condition}}
{%endfor%}