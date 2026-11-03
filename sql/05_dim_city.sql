CREATE TABLE analytics.dim_city
(
    city_id      UInt32,
    province_id  UInt16,
    name_fa      String
)
ENGINE = MergeTree ORDER BY city_id;