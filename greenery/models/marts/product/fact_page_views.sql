with
events as (
    select * from {{ ref('stg_postgres__events') }}
),

order_items as (
    select * from {{ ref('stg_postgres__order_items') }}
),

session_timing_agg as (
select * from {{ ref('int_session_timing') }}
)

select
    e.session_guid,
    e.user_guid,
    coalesce(e.product_guid, oi.product_guid) as product_guid,
    session_started_at_utc,
    session_ended_at_utc,
    sum(case when e.event_type = 'page_view' then 1 else 0 end) as page_views,
    sum(case when e.event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts,
    sum(case when e.event_type = 'checkout' then 1 else 0 end) as checkouts,
    sum(case when e.event_type = 'package_shipped' then 1 else 0 end) as packages_shipped,
    datediff('minute', session_started_at_utc, session_ended_at_utc) as session_length_minutes
from events e
left join order_items oi on oi.order_guid = e.order_guid
left join session_timing_agg s on s.session_guid = e.session_guid
group by 1, 2, 3, 4, 5