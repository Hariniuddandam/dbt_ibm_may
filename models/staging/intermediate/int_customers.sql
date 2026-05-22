with c as 
(select customer_id, name as customer_name ,address,
 phone_number, account_balance, market_segment,nation_id, comment from stg_customers
 where customer_id <= 30010),
 n as       
 (select nation_id,region_key,nation_name from stg_nations),
 r as
 (select region_id, name as region_name from stg_regions)
 select c.* exclude(nation_id,comment),n.nation_name,r.region_name,c.comment
from c join n on c.nation_id = n.nation_id
join r on n.region_key = r.region_id

