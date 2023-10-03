WITH
devices AS (
  SELECT * FROM {{ ref('dim_customer__devices') }}
),
transactions_daily AS (
  SELECT * FROM {{ ref('fct_payment__transactions_daily') }}
),
transactions_grouped AS (
  SELECT
    d.device_type,
    SUM(t.transaction_count) AS total_transaction_count
  FROM
    devices d
    LEFT JOIN
    transactions_daily t ON d.device_key = t.device_key
  GROUP BY
    1
)
SELECT
  *,
  ROUND(total_transaction_count / SUM(total_transaction_count) OVER (PARTITION BY 1),4) AS pct_all_transactions
FROM
  transactions_grouped
