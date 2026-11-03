SELECT
    event_date AS day,
    count() AS dau
FROM (
    SELECT
        toDate(created_at) AS event_date,
        user_id,
        sum(watched_ms) AS user_daily_watch_ms
    FROM analytics.fact_watch_log
    WHERE watched_ms > 0 
      AND watched_ms < 4 * 3600000
      AND created_at >= toUnixTimestamp(now() - INTERVAL 30 DAY)
    GROUP BY event_date, user_id
    HAVING user_daily_watch_ms >= 15 * 60 * 1000  -- حداقل ۱۵ دقیقه تماشا در طول روز
)
GROUP BY day
ORDER BY day;
