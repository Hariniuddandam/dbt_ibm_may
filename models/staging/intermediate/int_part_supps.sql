SELECT
    *,

    {{ usd_eur('COST') }} AS COST_EUR

FROM {{ ref('stg_part_supps') }}