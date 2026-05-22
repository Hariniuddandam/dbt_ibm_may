SELECT
sp.*,
ascaqsp.average_available_quantity,
ascaqsp.average_supply_cost
    FROM {{ref('supplier_parts')}} as sp
        JOIN {{ref('average_cost')}} as ascaqsp
        ON
        ascaqsp.part_key = sp.part_key
