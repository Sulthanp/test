{{ config(materialized='table') }}


with tb1 as (
    select
    id ,
    name,
    salary
    from {{source('datafeed_shared_schema','retro')}}
    )
select * from tb1
