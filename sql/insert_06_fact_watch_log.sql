INSERT INTO analytics.fact_watch_log (watch_id, created_at, user_id, media_id, watched_ms)
SELECT
    number + 1 AS watch_id,
    fromUnixTimestamp64Milli(
        (toInt64(toUnixTimestamp(toStartOfDay(now(), 'Asia/Tehran'))) - days_ago * 86400 + tehran_sec) * 1000 + ms,
        'UTC') AS created_at,
    toUUID(concat('00000000-0000-0000-0000-', leftPad(toString(u), 12, '0'))) AS user_id,
    toUUID(concat('00000000-0000-0000-',
                  leftPad(toString(arrayElement(types, p)), 4, '0'),
                  '-00000000000', toString(arrayElement(seqs, p)))) AS media_id,
    toUInt32(arrayElement(durs, p) * frac) AS watched_ms
FROM
(
    SELECT
        number,
        -- ۲۰ خانه‌ی وزن‌دار از محتواهای قابل تماشا
        [1,1,1,3,3,6,6,6,8,8,9,9,10,10,10,10,11,11,1,6]  AS types,
        [1,2,2,1,2,1,1,2,1,2,1,2,1,1,2,2,1,2,1,2]        AS seqs,
        [8700000,5460000,5460000,1620000,5400000,1320000,1320000,1320000,6300000,6300000,
         14400000,7200000,210000,210000,245000,245000,215000,198000,8700000,1320000] AS durs,
        [0.25,0.90,0.90,0.95,0.60,0.80,0.80,0.50,0.70,0.40,
         0.15,0.50,0.90,0.90,0.65,0.65,0.95,0.50,0.25,0.50] AS bases,
        toUInt8(1 + cityHash64(number, 1) % 20) AS p,
        toInt64(1 + cityHash64(number, 2) % 30) AS days_ago,
        cityHash64(number, 3) % 200 AS r,
        multiIf(
            number < 9, arrayElement([7, 8, 10, 7, 8, 10, 7, 8, 10], number + 1),
            r < 74,  1,
            r < 128, 9,
            r < 156, 2,
            r < 176, 3,
            r < 184, 4,
            r < 192, 5,
            6) AS u,
        cityHash64(number, 7) % 20 AS b,
        cityHash64(number, 8) AS hh,
        toInt64(multiIf(
            b < 2,  7 * 3600  + hh % (4 * 3600),
            b < 5,  11 * 3600 + hh % (6 * 3600),
            b < 8,  17 * 3600 + hh % (3 * 3600),
            b < 18, 20 * 3600 + hh % (4 * 3600),
            hh % (2 * 3600))) AS tehran_sec,
        toInt64(cityHash64(number, 9) % 1000) AS ms,
        least(1.0, greatest(0.03,
            arrayElement(bases, p) + (toInt64(cityHash64(number, 10) % 31) - 15) / 100.0)) AS frac
    FROM numbers(600)
);