{{ config(materialized= "table" ) }}

SELECT
    EXTRACT(YEAR FROM lpep_pickup_datetime) AS year,
    CASE
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 1 THEN 'January'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 2 THEN 'February'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 3 THEN 'March'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 4 THEN 'April'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 5 THEN 'May'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 6 THEN 'June'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 7 THEN 'July'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 8 THEN 'August'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 9 THEN 'September'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 10 THEN 'October'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 11 THEN 'November'
        WHEN EXTRACT(MONTH FROM lpep_pickup_datetime) = 12 THEN 'December'
        ELSE 'Other'  -- Optional: Handle unexpected month values
    END AS month_name,

    -- Count the number of passengers for each month
    COUNT(*) AS total_passengers
FROM {{ ref ("taxi_tripdata") }}
GROUP BY year, month_name
ORDER BY year, month_name
