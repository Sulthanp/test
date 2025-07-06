{{ config(materialized='table') }}

WITH tb1 as(
    select
    id,
    first_name,
    last_name,
    from {{source('datafeed_shared_schema','raw_customersdata')}})
select * from tb1 where id in (1,2,3,4,5)



