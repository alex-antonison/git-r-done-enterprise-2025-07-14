-- , lol as (
-- SELECT
--     row_number() OVER () AS movie_id,
--     "Title" AS title,
--     "US Gross" AS us_gross,
--     "Worldwide Gross" AS worldwide_gross,
--     "US DVD Sales" AS us_dvd_sales,
--     "Production Budget" AS production_budget,
--     "Release Date" AS release_date,
--     cast(
--         date_part('year', strptime("Release Date", '%b %d %Y')) AS INTEGER
--     ) AS release_year,
--     "MPAA Rating" AS mpaa_rating,
--     "Running Time min" AS running_time_min,
--     "Distributor" AS distributor,
--     "Source" AS source,
--     "Major Genre" AS major_genres,
--     "Creative Type" AS creative_type,
--     "Director" AS director,
--     "Rotten Tomatoes Rating" AS rotten_tomatoes_rating,
--     "IMDB Rating" AS imdb_rating,
--     "IMDB Votes" AS imdb_votes
-- FROM
--     source_data
-- )
WITH filtered_movies AS (
    SELECT
        movie_id,
        title,
        release_year,
        imdb_rating,
        AVG(imdb_rating) OVER () AS avg_rating_for_all
    FROM {{ ref('stg_movies') }}
    WHERE major_genres like '%Romantic%'
),

rating_comp AS (
    SELECT
        movie_id,
        title,
        release_year,  
        imdb_rating,
        avg_rating_for_all,
        ABS(imdb_rating-avg_rating_for_all) AS dev_from_main_avg
    FROM filtered_movies
)

,ranked as (
SELECT
    movie_id,
    title,
    release_year,
    imdb_rating,
    dev_from_main_avg,
    avg_rating_for_all,
    ROW_NUMBER() OVER (ORDER BY dev_from_main_avg) AS rank
FROM rating_comp)

select
movie_id
,title
,release_year
,imdb_rating
,rank
from ranked where rank <=3