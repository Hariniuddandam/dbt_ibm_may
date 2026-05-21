SELECT
    s.s_suppkey AS supplier_id,
    p.p_partkey AS part_id,

    -- Inventory Value
    ps.ps_availqty * ps.ps_supplycost AS inventory_value_usd,

    
--  Inventory Value_eur
    (ps.ps_availqty * ps.ps_supplycost * 0.86)::numeric(18,2) AS inventory_value_eur,

    -- Unit Margin
    p.p_retailprice - ps.ps_supplycost AS unit_margin,

    -- Margin Percent
    ROUND(
        COALESCE(
            ((p.p_retailprice - ps.ps_supplycost) / NULLIF(p.p_retailprice, 0)) * 100,
            0
        ),
        2
    ) AS margin_per,

    -- Inventory Level
    CASE 
        WHEN ps.ps_availqty >= 8000 THEN 'HIGH'
        WHEN ps.ps_availqty >= 3000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS inventory_level,

    -- Supplier Financial Health
    CASE 
        WHEN s.s_acctbal > 5000 THEN 'PREMIUM'
        WHEN s.s_acctbal <= 0 THEN 'RISK'
        ELSE 'STANDARD'
    END AS supplier_financial_health,

    -- Supplier Data Status
    CASE 
        WHEN s.s_phone IS NULL OR s.s_address IS NULL THEN FALSE
        ELSE TRUE
    END AS data_status,

    -- Margin Status
    CASE 
        WHEN ps.ps_supplycost > p.p_retailprice THEN FALSE
        ELSE TRUE
    END AS margin_status_normal,

    CURRENT_TIMESTAMP() AS updated_at,
    CURRENT_USER() AS user_name

FROM SOURCEDB.MK_MALL.PARTS p
JOIN SOURCEDB.MK_MALL.PARTSUPPS ps 
    ON ps.ps_partkey = p.p_partkey
JOIN SOURCEDB.MK_MALL.SUPPLIERS s  
    ON ps.ps_suppkey = s.s_suppkey