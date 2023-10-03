WITH
stores AS (
  SELECT * FROM {{ ref('dim_customer__stores') }}
),
transactions_daily AS (
  SELECT * FROM {{ ref('fct_payment__transactions_daily') }}
)
SELECT
  s.typology,
  s.country,
  SUM(t.transaction_count) AS total_transaction_count,
  ROUND(
    SUM(t.total_transaction_amount) / SUM(t.transaction_count), 2
  ) AS avg_transaction_amount
FROM
  stores s
  INNER JOIN --Only over stores with any transaction
  transactions_daily t ON s.store_key = t.store_key
GROUP BY
  1,2
ORDER BY
  1,2
