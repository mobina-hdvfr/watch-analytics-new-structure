CREATE TABLE analytics.dim_province
(
    province_id  UInt16,
    name_fa      String
)
ENGINE = MergeTree ORDER BY province_id;