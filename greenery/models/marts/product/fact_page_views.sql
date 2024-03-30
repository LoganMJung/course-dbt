SELECT
    event_guid,
    created_at_utc,
    session_guid,
    user_guid,
    page_url
FROM
    {{ ref('stg_postgres__events') }}
WHERE
    event_type = 'page_view'