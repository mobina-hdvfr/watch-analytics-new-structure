SELECT 
    m.media_id,
    m.title_fa,
    round(sum(f.watched_ms) / 60000, 1) AS total_minutes
FROM analytics.fact_watch_log f
JOIN analytics.dim_media m FINAL ON f.media_id = m.media_id
GROUP BY m.media_id, m.title_fa
ORDER BY total_minutes DESC
LIMIT 5;
