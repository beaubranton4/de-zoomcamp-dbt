--JOIN TO CUMULATIVE TEAM STATS TO GET CURRENT STATS FOR TEAM
select *
from {{ ref('dim_zones') }}