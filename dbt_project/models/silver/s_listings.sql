{{ config(materialized = 'incremental', unique_key = 'listing_id') }}

SELECT
    LISTING_ID,
    HOST_ID,
    {{trim('PROPERTY_TYPE')}} AS PROPERTY_TYPE,
    {{trim('ROOM_TYPE')}} AS ROOM_TYPE,
    {{trim('CITY')}} AS CITY,
    {{trim('COUNTRY')}} AS COUNTRY,
    ACCOMODATES,
    BATHROOMS,
    BEDROOMS,
    PRICE_PER_NIGHT,
    {{tag('PRICE_PER_NIGHT')}} AS PRICE_TAG,
    CREATED_AT
FROM {{ref ("b_listings")}}