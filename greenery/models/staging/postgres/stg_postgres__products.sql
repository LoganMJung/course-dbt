{{
  config(
    materialized='view'
  )
}}

select 
    product_id product_guid,
	name product_name,
	price product_price,
    inventory product_inventory
from {{ source('postgres','products') }}