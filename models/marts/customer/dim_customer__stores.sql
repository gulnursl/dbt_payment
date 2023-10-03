WITH
stores AS (
  SELECT * FROM {{ ref('stg_backend__stores') }}
)
SELECT
  store_id,
  store_key,
  customer_key,
  typology,
  name,
  country,
  city,
  address,
  created_at
FROM
  stores
