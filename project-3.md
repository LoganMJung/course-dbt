## What is our overall conversion rate?

Conversion rate is defined as the # of unique sessions with a purchase event / total number of unique sessions. Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product

Answer: 62.47%

SQL:

```
SELECT count(DISTINCT (CASE WHEN CHECKOUTS >= 1 THEN session_guid ELSE NULL END)) / count(DISTINCT session_guid)
FROM dev_db.dbt_loganjuzillowgroupcom.fact_page_views
```

## What is our conversion rate by product?

Answer: 62.47%

SQL:

```
SELECT product_guid
	,count(DISTINCT (CASE WHEN CHECKOUTS >= 1 THEN session_guid ELSE NULL END)) / count(DISTINCT session_guid)
FROM dev_db.dbt_loganjuzillowgroupcom.fact_page_views
GROUP BY 1
```

## Which products had their inventory change from week 2 to week 3? 

Answer: Pothos, Philodendron, Bamboo, ZZ Plant, Monstera, String of pearls

SQL:

```
SELECT name
FROM DEV_DB.DBT_LOGANJUZILLOWGROUPCOM.PRODUCTS_SNAPSHOT
WHERE product_id IN (
		SELECT product_id
		FROM DEV_DB.DBT_LOGANJUZILLOWGROUPCOM.PRODUCTS_SNAPSHOT
		WHERE dbt_valid_to IS NOT NULL
		)
	AND dbt_valid_to IS NULL
ORDER BY product_id ASC
	,dbt_valid_from ASC;
```

