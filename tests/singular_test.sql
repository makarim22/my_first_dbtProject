-- Test name: test_fare_amount_positive

SELECT 
 COUNT(*) AS invalid_rows,
 CASE WHEN fare_amount < 0 THEN 'Invalid: Negative fare amount' ELSE NULL END AS assertion_result
FROM {{ref("taxi_tripdata")}}
group by assertion_result


 

