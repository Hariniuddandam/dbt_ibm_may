
select 
{{ dbt_utils.generate_surrogate_key(['order_id','customer_id'])}} as order_key,

order_id, order_date, customer_id, clerk_name, total_price, 
status_code, priority_code, ship_priority, comment  from {{ref('stg_orders')}}

{% if is_incremental() %}
where  upd_date > (select max(upd_date) from {{this}} )
{% endif %}
