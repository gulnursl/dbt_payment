WITH
devices AS (
  SELECT * FROM {{ ref('stg_backend__devices') }}
)
SELECT
  device_id,
  device_key,
  store_key,
  device_type
FROM
  devices
