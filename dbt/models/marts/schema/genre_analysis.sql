SELECT
    major_genres,
    SUM(us_gross) AS money
FROM {{ ref('stg_movies') }}
GROUP BY major_genres
ORDER BY money DESC
LIMIT 5