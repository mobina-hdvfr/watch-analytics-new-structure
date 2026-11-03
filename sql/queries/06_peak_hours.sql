WITH hourly_aggregated AS (
    SELECT
        ((toDayOfWeek(toDate(toDateTime(created_at))) + 1) % 7) + 1 AS iran_day_of_week,
        toHour(toDateTime(created_at)) AS event_hour,
        count() AS total_views,
        round(sum(watched_ms) / (1000 * 3600), 2) AS total_watch_hours,
        uniq(user_id) AS active_users
    FROM analytics.fact_watch_log
    WHERE toDate(toDateTime(created_at)) >= today() - 28 
      AND toDate(toDateTime(created_at)) < today()
      AND watched_ms > 0 
      AND watched_ms < 4 * 3600000
    GROUP BY iran_day_of_week, event_hour
),
ranked_hours AS (
    SELECT
        iran_day_of_week,
        event_hour,
        total_views,
        total_watch_hours,
        active_users,
        row_number() OVER (
            PARTITION BY iran_day_of_week 
            ORDER BY total_views DESC, active_users DESC
        ) AS rnk
    FROM hourly_aggregated
)
SELECT
    case iran_day_of_week
        when 1 then 'شنبه'
        when 2 then 'یکشنبه'
        when 3 then 'دوشنبه'
        when 4 then 'سه‌شنبه'
        when 5 then 'چهارشنبه'
        when 6 then 'پنج‌شنبه'
        when 7 then 'جمعه'
    end AS day_name,
    event_hour AS peak_hour,
    total_views,
    active_users,
    total_watch_hours
FROM ranked_hours
WHERE rnk = 1
ORDER BY iran_day_of_week;
