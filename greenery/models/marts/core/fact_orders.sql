{{
  config(
    materialized='table'
  )
}}
with orders as (
  select * from {{ ref('stg_postgres__orders') }}
),

addresses as (
  select * from {{ ref('stg_postgres__addresses') }}
),

promos as (
  select * from {{ ref('stg_postgres__promos') }}
),

products_in_orders as (
  select 
    order_guid,
    count(product_guid) as products_in_order
  from {{ ref('stg_postgres__order_items') }} 
  group by 1   
)

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
    orders as o
    LEFT JOIN promos as p ON o.promo_guid = p.promo_guid
    --LEFT JOIN addresses as a on a.address_guid = o.address_guid
    LEFT JOIN products_in_orders as pin on pin.order_guid = o.order_guid
    