{{
    config(
        materialized = 'view'
        , unique_key = 'session_guid'
        
    )
}}

WITH session_purchase
AS (
	SELECT e.session_guid
		,e.user_guid
		,e.order_guid
		,min(CASE WHEN event_type = 'checkout' THEN created_at_utc END) AS checkout_at
		,min(CASE WHEN event_type = 'package_shipped' THEN created_at_utc END) AS shipped_at
	FROM dbt_loganjuzillowgroupcom.stg_postgres__events e
	GROUP BY 1,2,3
	)
    
SELECT sp.*
	,oi.product_guid
	,oi.quantity
FROM session_purchase sp
JOIN dbt_loganjuzillowgroupcom.stg_postgres__order_items AS oi ON sp.order_guid = oi.order_guid