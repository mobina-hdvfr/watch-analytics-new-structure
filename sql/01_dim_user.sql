CREATE TABLE analytics.dim_user
(
    user_id         UUID,
    phone           String,
    first_name      String,
    last_name       String,
    email           String,
    email_verified  Bool,
    status          String,
    place_id        Int32,
    created_at      DateTime64(3, 'UTC'),
    updated_at      DateTime64(3, 'UTC'),
    last_login      DateTime64(3, 'UTC')
)
ENGINE = ReplacingMergeTree(updated_at)
ORDER BY user_id;