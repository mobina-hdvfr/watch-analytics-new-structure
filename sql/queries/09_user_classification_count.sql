WITH user_totals AS (
    SELECT
        user_id,
        round(sum(watched_ms) / 3600000, 1) AS user_hours
    FROM analytics.fact_watch_log
    WHERE watched_ms > 0 
      AND watched_ms < 4 * 3600000
      AND created_at >= toUnixTimestamp(now() - INTERVAL 30 DAY)
    GROUP BY user_id
    HAVING user_hours <= 720
),
user_segments AS (
    SELECT
        user_id,
        user_hours,
        multiIf(user_hours >= 60, 'Heavy',
                user_hours >= 20, 'Regular',
                user_hours >= 5,  'Light',
                'Casual') AS segment
    FROM user_totals
)
SELECT
    segment,
    count() AS total_users,
    round(avg(user_hours), 1) AS avg_hours,
    round(sum(user_hours), 1) AS segment_total_hours
FROM user_segments
GROUP BY segment
ORDER BY segment_total_hours DESC;
