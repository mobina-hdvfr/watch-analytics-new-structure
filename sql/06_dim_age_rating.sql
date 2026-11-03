CREATE TABLE analytics.dim_age_rating
(
    age_id  UInt8,
    label   String
)
ENGINE = MergeTree ORDER BY age_id;