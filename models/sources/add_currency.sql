SELECT
  *,  -- Select all existing columns
  ROUND(total_amount * 16241.5, 2) AS total_amount_idr  -- Add converted amount with rounding
FROM {{ref("taxi_tripdata")}}
