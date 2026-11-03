CREATE TABLE analytics.fact_watch_log
(
    watch_id    UInt64,
    created_at  DateTime64(3, 'UTC'),
    user_id     UUID,
    media_id    UUID,
    type_id     UInt8,             -- ۱ برای فیلم، ۲ برای سریال، ۸ فوتبال، ۹ کتاب صوتی و ...
    watched_ms  UInt32
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(created_at)
ORDER BY (created_at, user_id);