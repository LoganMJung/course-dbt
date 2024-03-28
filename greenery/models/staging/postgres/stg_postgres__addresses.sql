{{
  config(
    materialized='view'
  )
}}

select 
	address
	,zipcode
	,state
	,country
from {{ source('postgres','addresses') }}