{{config(materialized='table',
        transient='false')}}

With customers as (
  select
  id as customer_id,
  first_name,
  last_name
  from {{ref('customer')}}
  ),

 orders as ( 
    select
    order_id,
    customer_id,
    order_date,
    status,
from {{ref('orders')}}
     
    ),

    final as (
        select 
      customers.customer_id,
      customers.first_name,
      orders.order_date,
      orders.status,
      from customers
      left join orders using (customer_id)
    )
select * from final