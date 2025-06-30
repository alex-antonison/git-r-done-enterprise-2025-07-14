SELECT
    release_year,
    mpaa_rating,
    major_genres,
    sum(worldwide_gross) AS total_worldwide_gross
FROM {{ ref('stg_movies') }}
GROUP BY
    release_year,
    mpaa_rating,
    major_genres
