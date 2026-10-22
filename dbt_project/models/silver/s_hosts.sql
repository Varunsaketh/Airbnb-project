{{ config(materilaized = 'incremental', unique_key = 'HOST_ID')}}

SELECT
    HOST_ID,
    {{replace('HOST_NAME')}} AS HOST_NAME,
    HOST_SINCE,
    IS_SUPER_HOST,
    RESPONSE_RATE,
    {{response_tag('RESPONSE_RATE')}} AS RESPONSE_TAG,
    CREATED_AT
FROM {{ref("b_hosts")}}