SELECT
    u.first_name,
    u.last_name,
    c.name_fa AS city,
    p.name_fa AS province,
    u.email_verified,
    fromUnixTimestamp64Milli(u.created_at, 'Asia/Tehran') AS created,
    fromUnixTimestamp64Milli(u.last_login, 'Asia/Tehran') AS last_login
FROM analytics.dim_user u
JOIN analytics.dim_city c ON c.city_id = u.place_id
JOIN analytics.dim_province p ON p.province_id = c.province_id
ORDER BY u.user_id;