select 
	address
	,zipcode
	,state
	,country
from {{ source('postgres','addresses') }}