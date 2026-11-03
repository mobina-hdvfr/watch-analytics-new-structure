CREATE TABLE analytics.dim_genre
(
    genre_id      Int32,
    name_en       String,
    name_fa	      String,
    created_at    DateTime64(3, 'UTC'),
    updated_at    DateTime64(3, 'UTC'),
    deleted_at    DateTime64(3, 'UTC')    -- 1970-01-01 یعنی حذف‌نشده
)
ENGINE = ReplacingMergeTree(updated_at)
ORDER BY genre_id;