{{
  config(
    materialized='table'
  )
}}

SELECT
    user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    created_at_utc,
    address,
    zipcode,
    state,
    country
FROM
    {{ ref('stg_postgres__users') }} u
    LEFT JOIN {{ ref('stg_postgres__addresses') }} A
    ON A.address = u.address_guid