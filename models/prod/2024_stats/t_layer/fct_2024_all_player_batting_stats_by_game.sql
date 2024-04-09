--GET RID OF PITCHER STATS 
--COMBINE NAMES OF PLAYERS WHO HAVE TWO DIFFERENT NAMES
--ALL NAMES TO CAMEL CASE


with add_name as(

select 
    *,
    CONCAT(
        IF(ARRAY_LENGTH(split_name) > 1, 
        CONCAT(
        UPPER(SUBSTR(split_name[OFFSET(1)], 1, 1)), 
        LOWER(SUBSTR(split_name[OFFSET(1)], 2))
        ), 
        ""
        ),
        " ",
        CONCAT(
            UPPER(SUBSTR(split_name[OFFSET(0)], 1, 1)), 
            LOWER(SUBSTR(split_name[OFFSET(0)], 2))
        )
    ) as player_name
FROM (
  SELECT 
    *,
    SPLIT(REGEXP_REPLACE(player, r',', ''), ' ') AS split_name
  FROM {{ ref('stg_2024_all_batting_box_scores') }}
)
)

select *
    from add_name





--CODE ATTEMPT TO SOLVE INCORRECTLY ENTERED NAMES ACROSS DIFFERENT GAMES

-- with names_parsed as(

-- SELECT DISTINCT
--   player,
--   IF(ARRAY_LENGTH(split_name) > 1, 
--     CONCAT(
--       UPPER(SUBSTR(split_name[OFFSET(1)], 1, 1)), 
--       LOWER(SUBSTR(split_name[OFFSET(1)], 2))
--     ), 
--     NULL
--   ) as player_first_name,
--   CONCAT(
--     UPPER(SUBSTR(split_name[OFFSET(0)], 1, 1)), 
--     LOWER(SUBSTR(split_name[OFFSET(0)], 2))
--   ) as player_last_name,
--   concat(
--     IF(ARRAY_LENGTH(split_name) > 1, 
--     CONCAT(
--       UPPER(SUBSTR(split_name[OFFSET(1)], 1, 1)), 
--       LOWER(SUBSTR(split_name[OFFSET(1)], 2))
--     ), 
--     ""
--   ),
--   " ",
--   CONCAT(
--     UPPER(SUBSTR(split_name[OFFSET(0)], 1, 1)), 
--     LOWER(SUBSTR(split_name[OFFSET(0)], 2))
--   ) 
--   ) as player_name,
--   team
-- FROM (
--   SELECT 
--     player,
--     SPLIT(REGEXP_REPLACE(player, r',', ''), ' ') AS split_name,
--     team
--   FROM {{ ref('stg_2024_all_batting_box_scores') }}
-- )
-- )

-- ,player_name_lookup as(
-- select distinct 
--     player,
--     player_last_name,
--     team,
--     player_name
-- from names_parsed
-- where player_first_name is not null
-- )

-- select 
--     case    
--         when n.player_first_name is NULL then coalesce(l.player_name, n.player_name)
--         else n.player_name
--     end as player_name,
--     b.*
-- from {{ ref('stg_2024_all_batting_box_scores') }} b
-- left join names_parsed n
--     on b.player = n.player
-- left join player_name_lookup l
--     on n.player_last_name = l.player_last_name
--     and n.team = l.team

-- Get name of player, split into first and last
-- If only one name, it will be the last name
-- If only one name (i.e no first name), then we need to use the lookup table 
    -- Based on last name and team, lookup full name based on data from other games
