SELECT
    *,

    {{ usd_eur('RETAIL_PRICE') }} AS RETAIL_PRICE_EUR

FROM {{ ref('stg_parts') }}