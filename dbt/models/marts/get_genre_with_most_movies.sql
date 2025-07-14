
SELECT
    major_genres,
    COUNT(DISTINCT movie_id) as num_movies
FROM {{ ref('stg_movies') }}
GROUP BY
    major_genres
ORDER BY num_movies DESC
