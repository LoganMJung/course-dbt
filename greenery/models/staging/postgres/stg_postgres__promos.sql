{{
  config(
    materialized='view'
  )
}}

select 
    promo_id promo_guid,
	discount promo_discount,
	status as promo_status
from {{ source('postgres','promos') }}
