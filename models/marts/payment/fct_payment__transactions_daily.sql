{{
  config(materialized='view')
}}
-- As the source intermediate tables are already stored physically,
--   we can materialize this just as a view.

WITH
transactions_excl_current_date AS (
  SELECT * FROM {{ ref('int_payment__txn_aggr_excl_current_date') }}
),
transactions_current_date AS (
  SELECT * FROM {{ ref('int_payment__txn_aggr_current_date') }}
)
SELECT
  device_key,
  store_key,
  product_sku,
  category_name,
  transaction_status,
  created_date,
  happened_date,
  total_transaction_count,
  total_transaction_amount
FROM
  transactions_excl_current_date
UNION ALL
SELECT
  device_key,
  store_key,
  product_sku,
  category_name,
  transaction_status,
  created_date,
  happened_date,
  total_transaction_count,
  total_transaction_amount
FROM
  transactions_current_date
