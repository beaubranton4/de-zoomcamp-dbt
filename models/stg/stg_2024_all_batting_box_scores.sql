select *
from {{ source('stg','2024_ncaa_batting_stats') }}