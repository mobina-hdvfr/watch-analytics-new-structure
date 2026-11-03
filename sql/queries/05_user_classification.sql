SELECT
    user_id,
    count() AS events,
    round(sum(watched_ms) / 3600000, 1) AS hours,
    multiIf(hours >= 60, 'Heavy', hours >= 20, 'Regular', hours >= 5, 'Light', 'Casual') AS segment
FROM analytics.fact_watch_log
WHERE watched_ms > 0 AND watched_ms < 4 * 3600000
GROUP BY user_id
ORDER BY hours DESC;