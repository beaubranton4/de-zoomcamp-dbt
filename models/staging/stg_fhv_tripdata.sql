{{ config(materialized='view') }}

select 
    dispatching_base_num,
    pickup_datetime,
    DATE_TRUNC(EXTRACT(DATE FROM pickup_datetime), MONTH)  as pickup_month,
    dropoff_datetime,
    pulocationid,
    dolocationid, 
    sr_flag, 
    affiliated_base_number
from {{ source('staging','fhv_tripdata') }}
where EXTRACT(DATE FROM pickup_datetime) >= '2019-01-01'
and EXTRACT(DATE FROM pickup_datetime) <= '2019-12-31'