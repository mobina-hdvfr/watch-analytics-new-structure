-- درصد تماشای هر محتوا
SELECT
    m.title_en,
    count() AS plays,
    round(avg(least(f.watched_ms / m.duration_ms, 1)) * 100, 1) AS completion_pct
FROM analytics.fact_watch_log f
JOIN analytics.dim_media m FINAL ON f.media_id = m.media_id
WHERE m.duration_ms > 0 AND f.watched_ms < 4 * 3600000
GROUP BY m.title_en
ORDER BY completion_pct;