select date_day as date
from( 
{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2024-02-16' as date)", 
    end_date="cast(current_date() as date)"
   )
}}
) 
where DATE_TRUNC(date_day, DAY) <= (select max(date) from {{ ref('stg_all_batting_box_scores') }})