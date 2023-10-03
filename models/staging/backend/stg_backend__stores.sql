WITH
store AS (
  SELECT * FROM {{ source('backend', 'store') }}
)
SELECT
  MD5(id::VARCHAR) AS store_key,
  MD5(customer_id::VARCHAR) AS customer_key,
  id AS store_id,
  customer_id,
  typology,
  name,
  country,
  city,
  address,
  created_at
FROM
  store
