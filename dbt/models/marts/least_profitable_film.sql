SELECT
    title,
    production_budget,
    worldwide_gross,
    worldwide_gross - production_budget as profit

FROM {{ ref('stg_movies') }}
order by worldwide_gross - production_budget asc