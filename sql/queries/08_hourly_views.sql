-- ساعت اوج (وقت تهران)
SELECT toHour(toTimeZone(created_at, 'Asia/Tehran')) AS hour, count() AS plays
FROM analytics.fact_watch_log
GROUP BY hour
ORDER BY hour;