{{ config(materialized='view') }}

select 
    dispatching_base_num,
    pickup_datetime,
    dropoff_datetime,
    pulocationid,
    dolocationid, 
    sr_flag, 
    affiliated_base_number
from {{ source('staging','fhv_tripdata') }}
where EXTRACT(DATE FROM pickup_datetime) >= '2019-01-01'
and EXTRACT(DATE FROM pickup_datetime) <= '2019-12-31'