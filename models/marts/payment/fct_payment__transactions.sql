{{
  config(materialized='incremental')
}}

WITH
transactions AS (
  SELECT * FROM {{ ref('stg_backend__transactions') }}
)
SELECT
  transaction_id,
  transaction_key,
  device_key,
  product_sku,
  product_name,
  category_name,
  card_key,
  cvv_key,
  transaction_status,
  transaction_amount,
  created_at,
  happened_at
FROM
  transactions
{% if is_incremental() %}
WHERE 
  created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}
