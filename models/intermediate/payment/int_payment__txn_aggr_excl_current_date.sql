{{
  config(materialized='incremental')
}}

WITH
transactions AS (
  SELECT * FROM {{ ref('stg_backend__transactions') }}
),
devices AS (
  SELECT * FROM {{ ref('stg_backend__devices') }}
),
transactions_filtered AS (
  SELECT 
    *,
    MAX(created_at) OVER (PARTITION BY 1) AS _report_date
  FROM
    transactions
  WHERE 
    created_at::DATE < CURRENT_DATE 
  {% if is_incremental() %}
    AND created_at > (SELECT MAX(_report_date) FROM {{ this }})
  {% endif %}
)
SELECT
  _report_date,
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
  transactions_filtered t
  LEFT JOIN
  devices d ON t.device_key = d.device_key
GROUP BY
  1,2,3,4,5,6,7,8
