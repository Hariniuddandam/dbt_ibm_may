with parts as (
    select
        p_partkey as part_id,
        p_name as name,
        p_type as type,
        p_size as size,
        p_mfgr as manufacturer,
        p_brand as brand,
        p_comment as comment,
        p_container as container,
        p_retailprice as retail_price
    from {{ source('src','parts')}}
),

part_supplier as (
    select
        ps_suppkey as supplier_id,
        ps_partkey as part_id,
        ps_availqty as available_quantity,
        ps_supplycost as cost
    from {{ source('src','PARTSUPPS')}}
)

select
    p.part_id,
    p.name,
    p.type,
    p.size,
    p.manufacturer,
    p.brand,
    p.comment,
    p.container,
    p.retail_price
    --ps.supplier_id,
    --ps.available_quantity,
    --ps.cost
from parts p
join part_supplier ps
    on p.part_id = ps.part_id