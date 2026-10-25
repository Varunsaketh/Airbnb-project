{{
    config(
        materialized='ephemeral'
    )
}}
SELECT
    BOOKING_ID,
    BOOKING_STATUS,
    BOOKING_DATE,
    BOOKING_CREATED_AT
FROM {{ref('obt')}}
