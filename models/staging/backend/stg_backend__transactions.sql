WITH
transaction AS (
  SELECT * FROM {{ source('backend', 'transaction') }}
)
SELECT
  MD5(id::VARCHAR) AS transaction_key,
  MD5(device_id::VARCHAR) AS device_key,
  id AS transaction_id,
  device_id,
  product_sku,
  product_name,
  category_name,
  MD5(REPLACE(card_number, ' ', '')) AS card_key,
  MD5(cvv) AS cvv_key,
  status AS transaction_status,
  amount AS transaction_amount,
  created_at,
  happened_at
FROM
  transaction
