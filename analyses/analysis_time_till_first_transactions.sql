WITH
stores AS (
  SELECT * FROM {{ ref('dim_customer__stores') }}
),
devices AS (
  SELECT * FROM {{ ref('stg_backend__devices') }}
),
transactions AS (
  SELECT * FROM {{ ref('fct_payment__transactions') }}
),
transactions_ranked AS (
  SELECT
    s.store_key,
    s.store_id,
    EXTRACT(EPOCH FROM t.happened_at-s.created_at)/3600 AS transaction_at_hours_after,
    EXTRACT(DAY FROM t.happened_at-s.created_at) AS transaction_at_days_after,
    RANK() OVER (PARTITION BY s.store_key ORDER BY t.happened_at) AS transaction_rank,
    COUNT(t.transaction_key) OVER (PARTITION BY s.store_key) AS total_transaction_count
  FROM
    stores s
    INNER JOIN
    devices d ON s.store_key = d.store_key
    INNER JOIN --Only over stores with any transaction
    transactions t ON d.device_key = t.device_key
)
SELECT
  ROUND(AVG(transaction_at_hours_after),2) AS avg_hours_till_first_five_transactions,
  ROUND(AVG(transaction_at_days_after),2) AS avg_days_till_first_five_transactions
FROM
  transactions_ranked
WHERE
  total_transaction_count >= 5
  AND transaction_rank <= 5
