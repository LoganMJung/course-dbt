{{
  config(
    materialized='table'
  )
}}

select 
	ADDRESS_ID as address_guid
	,address
	,zipcode
	,state
	,country
from {{ source('postgres','addresses') }}

