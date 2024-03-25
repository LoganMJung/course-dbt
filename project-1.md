-- How many users do we have?

SELECT count(DISTINCT user_guid)
FROM dev_db.dbt_loganjuzillowgroupcom.stg_postgres__users;

-- 130 

--On average, how many orders do we receive per hour?

SELECT avg(hour_orders)
FROM (
	SELECT date_trunc('hour', CREATED_AT)
		,count(DISTINCT order_id) AS hour_orders
	FROM dev_db.dbt_loganjuzillowgroupcom.stg_postgres__orders
	GROUP BY 1
	ORDER BY 1
	);

--7.520833

--On average, how long does an order take from being placed to being delivered?

SELECT avg(datediff('second', CREATED_AT, DELIVERED_AT) / 60 / 60 / 24) AS hours_to_delivery
FROM dev_db.dbt_loganjuzillowgroupcom.stg_postgres__orders;

--3.89 days

--How many users have only made one purchase? Two purchases? Three+ purchases?
--Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
SELECT CASE 
		WHEN orders_per_user = 1
			THEN '1'
		WHEN orders_per_user = 2
			THEN '2'
		WHEN orders_per_user >= 3
			THEN '3+'
		ELSE NULL
		END AS order_groups
	,sum(orders_per_user) AS total_orders
FROM (
	SELECT USER_ID
		,count(ORDER_ID) AS orders_per_user
	FROM dev_db.dbt_loganjuzillowgroupcom.stg_postgres__orders
	GROUP BY 1
	)
GROUP BY 1
ORDER BY 1;


--On average, how many unique sessions do we have per hour?

SELECT avg(hour_sessions)
FROM (
	SELECT date_trunc('hour', CREATED_AT)
		,count(DISTINCT SESSION_ID) AS hour_sessions
	FROM dev_db.dbt_loganjuzillowgroupcom.stg_postgres__events
	GROUP BY 1
	ORDER BY 1
	);

-- 16.327586 unique sessions per hour



