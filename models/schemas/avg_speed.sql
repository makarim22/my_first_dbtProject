SELECT
  EXTRACT(HOUR
  FROM
    lpep_pickup_datetime) hour,
  ROUND(AVG(trip_distance / TIMESTAMP_DIFF(lpep_dropoff_datetime,
        lpep_pickup_datetime,
        SECOND))*3600, 1) speed
FROM
  {{ref("taxi_tripdata")}}
WHERE
  trip_distance > 0
  AND fare_amount/trip_distance BETWEEN 2
  AND 10
  AND lpep_dropoff_datetime > lpep_pickup_datetime
GROUP BY
  1
ORDER BY
  1 