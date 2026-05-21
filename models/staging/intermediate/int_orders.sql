SELECT
    *,

    {{ usd_eur('TOTAL_PRICE') }} AS TOTAL_PRICE_EUR

FROM {{ ref('stg_orders') }}


select order_id, order_date, customer_id, clerk_name, total_price, 
status_code, priority_code, ship_priority, comment  from {{ref('stg_orders')}}

