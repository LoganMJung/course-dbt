{{
  config(
    materialized='table'
  )
}}

SELECT
  u.user_guid,
  u.email,
  u.first_name,
  u.last_name,
  u.created_at_utc::DATE AS created_date,
FROM {{ ref('stg_postgres__users') }} u
