{{config(materialized='table',
        transient='false')}}
with customers as (
  select
  id as customer_id,
  first_name,
  last_name
  from {{source('datafeed_shared_schema','raw_customersdata')}}
  ),

 orders as ( 
    select
    order_id,
    customer_id,
    order_date,
    status,
from {{ref('orders')}}

),

c_o as (

 select
customer_id,
min(order_date) as first_order_date,
max(order_date) as most_recent_order_date,
count(order_id) as number_of_orders,
status,
 from orders
group by customer_id,status

),

final as (

select
customers.customer_id,
customers.first_name,
customers.last_name,
c_o.first_order_date,
c_o.most_recent_order_date,
coalesce(c_o.number_of_orders, 0) as number_of_orders
from customers
left join c_o using (customer_id)
)

select * from final


