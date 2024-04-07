with daily_batting_stats as(
    select *
    from {{ ref('stg_2024_all_batting_box_scores') }}
)

, game_sums as(
    select
        game_id,
        team,
        -- home_or_away,
        attendance,
        location, 
        sum(runs) as runs,
        sum(hits) as hits,
        sum(total_bases) as total_bases,
        sum(doubles) as doubles,
        sum(triples) as triples,
        sum(home_runs) as home_runs,
        sum(rbis) as rbis,
        sum(strikeouts) as strikeouts,
        sum(walks) as walks,
        sum(hit_by_pitch) as hit_by_pitch,
        sum(sacrifice_flys) as sacrifice_flys,
        sum(opp_double_play) as opp_double_play,
        sum(stolen_bases) as stolen_bases,
        sum(caught_stealing) as caught_stealing,
        sum(picked) as picked,
        sum(intentional_walks) as intentional_walks,
        sum(ground_into_double_play) as ground_into_double_play,
        sum(two_out_rbis) as two_out_rbis
    from daily_batting_stats
    group by all
)

select *
from game_sums