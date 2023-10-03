WITH
stores AS (
  SELECT * FROM {{ ref('dim_customer__stores') }}
),
transactions_daily AS (
  SELECT * FROM {{ ref('fct_payment__transactions_daily') }}
)
SELECT
  s.store_id,
  SUM(t.total_transaction_amount) AS store_total_transaction_amount
FROM
  stores s
  LEFT JOIN
  transactions_daily t ON s.store_key = t.store_key
WHERE
  t.transaction_status = 'accepted'
GROUP BY
  1
ORDER BY
  store_total_transaction_amount DESC 
LIMIT 10
