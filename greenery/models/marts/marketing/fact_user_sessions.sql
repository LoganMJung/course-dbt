{{
    config(
        materialized = 'view'
        , unique_key = 'session_guid'
        
    )
}}

SELECT
    s.session_guid,
    s.page_view,
    s.add_to_cart,
    s.checkout,
    s.delete_from_cart,
    s.account_created,
    s.package_shiped,
    u.*
FROM
    {{ ref('int_sessions_event_agg') }}
    s
    LEFT JOIN {{ ref('stg_postgres__users') }}
    u
    ON u.user_guid = s.user_guid