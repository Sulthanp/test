{{ config(
materialized="incremental",
unique_key ='id',
incremental_strategy= "merge"
) }}
select * from {{source('datafeed_shared_schema','orders')}} where id in (1,2,4,5)