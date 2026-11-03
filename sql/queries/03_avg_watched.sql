SELECT m.media_id, m.title_fa,
       round(avg(least(f.watched_ms / (m.duration_ms), 1)) * 100, 1) AS avg_watched_pct
FROM analytics.fact_watch_log f
JOIN analytics.dim_media m FINAL ON f.media_id = m.media_id
WHERE f.created_at >= toUnixTimestamp(now() - INTERVAL 7 DAY)
  AND f.watched_ms > 0 AND f.watched_ms < 4 * 3600000
GROUP BY m.media_id, m.title_fa
ORDER BY m.media_id;