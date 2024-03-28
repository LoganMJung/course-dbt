{{
  config(
    materialized='view'
  )
}}


select 
	order_id order_guid,
	product_id product_guid,
	quantity,
from {{ source('postgres','order_items') }}


