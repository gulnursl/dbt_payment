WITH
device AS (
  SELECT * FROM {{ source('backend', 'device') }}
)
SELECT
  MD5(id::VARCHAR) AS device_key,
  MD5(store_id::VARCHAR) AS store_key,
  id AS device_id,
  store_id,
  type AS device_type
FROM
  device
