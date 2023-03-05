#!/bin/bash
set -e
clickhouse-client --query "
    CREATE TABLE [IF NOT EXISTS] ecommerce.ecommerce (
        event_time String,
        event_type String,
        product_id UInt32,
        category_id UInt64,
        category_code String,
        brand String,
        price Float32,
        user_id UInt32,
        user_session UUID,
    )
    ENGINE = MergeTree()
    ORDER BY (event_time,user_session);
"
clickhouse-client --query "INSERT INTO ecommerce.ecommerce FORMAT CSVWithNames" < /docker-entrypoint-initdb.d/2019-Nov.csv
clickhouse-client --query "CREATE VIEW [IF NOT EXISTS] ecommerce.ecommerce_sanitized AS SELECT 
    toDateTime(substring(event_time,1,19)) AS event_time, 
    event_type, 
    product_id, 
    IF (empty(category_code), 'None', category_code) AS category_code, 
    IF (empty(brand), 'None', brand) AS brand, 
    price, 
    user_id, 
    user_session
FROM ecommerce.ecommerce"