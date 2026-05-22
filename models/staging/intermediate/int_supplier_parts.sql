{{ config(materialized='ephemeral') }}

With supplier_parts as (
  SELECT * from {{ source('src', 'suppliers') }}
    JOIN {{ source ('src','partsupps') }} 
        ON s_suppkey=ps_suppkey
            JOIN {{ source ('src','parts') }}
                ON ps_partkey=p_partkey
)

SELECT
s_suppkey as supplier_key,
s_name as supplier_name,
s_nationkey as nation_key,
s_acctbal as account_balance,
ps_availqty as available_quantity,
ps_supplycost as supply_cost,
p_partkey as part_key,
p_name as part_name,
p_mfgr as part_manufacturer,
p_brand as part_brand,
p_type as part_type,
p_size as part_size,
p_container as part_container,
p_retailprice as part_retail_price
FROM supplier_parts