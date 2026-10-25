{{config ( materialized='ephemeral')}}
WITH listings AS (
    SELECT
    LISTING_ID,
    PROPERTY_TYPE,
    ROOM_TYPE,
    CITY,
    COUNTRY,
    ACCOMODATES,
    BEDROOMS,
    BATHROOMS,
    PRICE_TAG,
    LISTINGS_CREATED_AT
    FROM {{ ref('obt') }}
)
SELECT * FROM listings