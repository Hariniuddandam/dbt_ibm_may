{{ config(materialized='ephemeral') }}

SELECT
part_key,
avg(available_quantity) as average_available_quantity,
avg(supply_cost) as average_supply_cost
    FROM {{ref('supplier_parts')}}
        GROUP BY
        part_key