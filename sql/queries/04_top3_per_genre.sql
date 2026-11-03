SELECT
    g.name AS genre,
    m.title AS title,
    count() AS views,
    round(sum(f.viewing_duration) / 60000, 1) as total_watch
FROM watch_analytics.fact_watch_log f
JOIN watch_analytics.dim_movie m FINAL ON f.multimedia_id = toString(m.huma_id)
JOIN watch_analytics.movie_genre mg FINAL ON mg.movie_id = m.huma_id
JOIN watch_analytics.dim_genre g FINAL ON g.id = mg.genre_id
--WHERE f.created_at >= toUnixTimestamp(now() - INTERVAL 7 DAY)
WHERE toDate(toDateTime(f.created_at)) >= today() - 7
  AND f.viewing_duration > 0 AND f.viewing_duration < 4 * 3600000
  AND mg._peerdb_is_deleted = 0
  AND mg.deleted_at < toDateTime64('2000-06-30 00:00:00', 6)
GROUP BY genre, title
ORDER BY genre, views DESC, total_watch
LIMIT 3 BY genre;