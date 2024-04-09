    select
        session_guid,
        min(created_at_utc) as session_started_at_utc,
        max(created_at_utc) as session_ended_at_utc
    from {{ ref('stg_postgres__events') }}
    group by 1