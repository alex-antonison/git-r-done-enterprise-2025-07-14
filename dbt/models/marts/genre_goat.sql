SELECT
    major_genres,
    director,
    AVG(imdb_rating) AS avg_rating,
FROM {{ ref('stg_movies') }}
WHERE major_genres != 'none'
GROUP BY
    director,
    major_genres
ORDER BY 
    avg_rating DESC
