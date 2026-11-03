CREATE TABLE analytics.media_genre
(
    media_id    UUID,
    genre_id    UInt16,
    genre_rank  UInt8,
    created_at  DateTime64(3, 'UTC'),
    updated_at  DateTime64(3, 'UTC'),
    deleted_at  DateTime64(3, 'UTC')    -- 1970-01-01 یعنی حذف‌نشده
)
ENGINE = ReplacingMergeTree(updated_at)
ORDER BY (media_id, genre_id);