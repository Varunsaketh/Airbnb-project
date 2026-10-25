{{config ( materialized='ephemeral')}}

with hosts AS (
    SELECT
        HOST_ID,
        HOST_NAME,
        HOST_SINCE,
        IS_SUPER_HOST,
        HOSTS_CREATED_AT,
        RESPONSE_TAG
    FROM {{ ref('obt') }}
)
SELECT * FROM hosts