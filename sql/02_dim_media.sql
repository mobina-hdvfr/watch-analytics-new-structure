CREATE TABLE analytics.dim_media
(
    media_id      UUID,
    type_id       UInt8,
    title_fa      String,
    title_en      String,
    title_enfa    String,
    synopsis_fa   String,
    synopsis_en   String,
    duration_ms   UInt64,
    release_date  Date32,       -- 1970-01-01 یعنی نامعلوم
    year          UInt16,
    age_id        UInt8,
    created_at    DateTime64(3, 'UTC'),
    deleted_at    DateTime64(3, 'UTC'),   -- 1970-01-01 یعنی حذف‌نشده
    updated_at    DateTime64(3, 'UTC')
)
ENGINE = ReplacingMergeTree(updated_at)
ORDER BY media_id;