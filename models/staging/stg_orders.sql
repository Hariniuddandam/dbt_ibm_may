{{config(materialized='view')}}


with sources as (
    select * 
    from {{ source('src','orders') }}
),

changed as (
    select
        o_orderkey as order_id,
        o_custkey as customer_id,
        o_comment as comment,
        o_clerk as clerk_name,
        o_totalprice as total_price,
        o_orderstatus as status_code,
        o_orderpriority as priority_code,
        o_shippriority as ship_priority,
        o_orderdate as order_date
    from sources
)

select * from changed