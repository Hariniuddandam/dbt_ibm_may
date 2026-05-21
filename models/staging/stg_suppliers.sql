with suppliers as (
    select
        s_suppkey as supplier_id,
        s_nationkey as nation_id,
        s_name as supplier_name,
        s_address as supplier_address,
        s_phone as phone_number,
        s_comment as comment,
        s_acctbal as account_balance,
        updated_time as updated_time
    from  {{ source('src','suppliers')}}
)

select * from suppliers