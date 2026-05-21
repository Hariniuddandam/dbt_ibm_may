SELECT
    *,

    {{ usd_eur('EXTENDED_PRICE') }} AS EXTENDED_PRICE_EUR

FROM {{ ref('stg_line_items') }}
