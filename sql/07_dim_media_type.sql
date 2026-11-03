CREATE TABLE analytics.dim_media_type
(
    type_id  UInt8,
    name     String
)
ENGINE = MergeTree ORDER BY type_id;