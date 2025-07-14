
SELECT
AVG(production_budget),
release_year
FROM  {{ref('stg_movies')}}
WHERE release_year = 2024
GROUP BY release_year