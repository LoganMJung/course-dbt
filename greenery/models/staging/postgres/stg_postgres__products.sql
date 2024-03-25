select 
    product_id,
	name product_name,
	price,
    inventory
from {{ source('postgres','products') }}