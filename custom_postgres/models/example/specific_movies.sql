{% set film_title = 'Blade Runner 2049' %}

SELECT *
FROM {{ ref('films') }}
WHERE title = '{{ film_title }}'