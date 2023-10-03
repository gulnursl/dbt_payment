WITH
transactions_daily AS (
  SELECT * FROM {{ ref('fct_payment__transactions_daily') }}
)
SELECT
  product_sku,
  SUM(total_transaction_amount) AS product_total_transaction_amount
FROM
  transactions_daily
WHERE
  transaction_status = 'accepted'
GROUP BY
  1
ORDER BY
  product_total_transaction_amount DESC
LIMIT 10
