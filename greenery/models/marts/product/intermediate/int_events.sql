SELECT session_guid
	,COUNT(DISTINCT order_guid) AS order_count
FROM {{ ref('stg_postgres__events') }}
WHERE order_guid IS NOT NULL
GROUP BY ALL
