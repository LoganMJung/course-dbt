{{
  config(
    materialized='table'
  )
}}

SELECT
    o.order_guid,
    o.created_at_utc AS ordered_at,
    o.shipping_cost,
    o.order_total,
    o.tracking_guid,
    o.shipping_service,
    o.estimated_delivery_at_utc,
    o.delivered_at_utc,
    o.order_status,
    p.promo_guid,
    p.promo_discount
FROM
    {{ ref('stg_postgres__orders') }}
    o
    LEFT JOIN {{ ref('stg_postgres__promos') }}
    p
    ON o.promo_guid = p.promo_guid