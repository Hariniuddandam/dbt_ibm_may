select customer_id,account_balance from {{ref('int_customers')}}
 where account_balance between -10 and 0;