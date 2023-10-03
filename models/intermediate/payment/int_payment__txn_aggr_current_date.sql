{{
  config(materialized='table')
}}

WITH
transactions AS (
  SELECT * FROM {{ ref('stg_backend__transactions') }}
),
devices AS (
  SELECT * FROM {{ ref('stg_backend__devices') }}
)
SELECT
  t.device_key,
  d.store_key,
  t.product_sku,
  t.category_name,
  t.transaction_status,
  t.created_at::DATE AS created_date,
  t.happened_at::DATE AS happened_date,
  COUNT(*) AS total_transaction_count,
  SUM(t.transaction_amount) AS total_transaction_amount
FROM
  transactions t
  LEFT JOIN
  devices d ON t.device_key = d.device_key
WHERE 
  t.created_at::DATE = CURRENT_DATE
GROUP BY
  1,2,3,4,5,6,7
