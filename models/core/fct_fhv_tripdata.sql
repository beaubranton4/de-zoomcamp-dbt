{{ config(materialized='table') }}

with fhv_data as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
), 

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)

select
    f.dispatching_base_num,
    f.pickup_datetime,
    f.dropoff_datetime,
    -- pulocationid,
    -- dolocationid, 
    pickup_zone.zone as pickup_zone,
    dropoff_zone.zone as dropoff_zone,
    f.sr_flag, 
    f.affiliated_base_number
from fhv_data f
inner join dim_zones as pickup_zone
on f.pulocationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on f.dolocationid = dropoff_zone.locationid