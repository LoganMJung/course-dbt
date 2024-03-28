{{
  config(
    materialized='view'
  )
}}

SELECT 
    id AS superhero_guid,
    name,
    gender,
    eye_color,
    race,
    hair_color,
    NULLIF(height, -99) AS height,
    publisher,
    skin_color,
    alignment,
    NULLIF(weight, -99) AS weight_lbs,
    NULLIF(weight, -99)*0.453592 AS weight_kg
FROM {{ source('postgres', 'superheroes') }}