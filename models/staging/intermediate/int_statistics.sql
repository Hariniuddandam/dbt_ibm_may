select 
STS.SUPPLIER_ID,
STS.SUPPLIER_NAME,
PTS.PART_ID,
PTS.SUPPLIER_ID as PART_SUPPLIER_ID, -- Added alias here to prevent duplication
PTS.available_quantity*PTS.supplycost as Inventory_Value ,
pt.retail_price-pts.supplycost as unit_margin , 
((pt.retail_price-pts.supplycost)/pt.retail_price*100)::number(4,2) as margin_per,
case 
    when PTS.AVAILABLE_QUANTITY>=8000 THEN 'HIGH'
    WHEN PTS.AVAILABLE_QUANTITY>=3000 THEN 'MEDIUM'
    ELSE 'LOW'
END AS Inventory_Level,
case 
    when STS.ACCOUNT_BALANCE>5000 THEN 'PREMIUM'
    WHEN STS.ACCOUNT_BALANCE<=5000 THEN 'STANDARD'
    WHEN STS.ACCOUNT_BALANCE<=0 THEN 'RISK'
END  AS Supplier_Financial_Health ,
CASE 
    WHEN STS.PHONE_NUMBER IS NULL OR STS.SUPPLIER_ADDRESS IS NULL THEN 'FALSE'
    ELSE 'TRUE' 
END AS DATA_STATUS,
CASE 
    WHEN PTS.SUPPLYCOST > PT.RETAIL_PRICE THEN 'FALSE'
    ELSE 'TRUE' 
END AS Margin_Status_Normal,
CURRENT_TIMESTAMP() AS UPDATED_AT,
CURRENT_USER() AS USER
 from {{ref('stg_parts')}} pt join {{ref('stg_part_supps')}} pts 
 on pts.part_id=pt.part_id JOIN {{ref('stg_suppliers')}} STS 
 on sts.supplier_id=pts.supplier_id 
