{% macro total_fare_by_payment(taxi_tripdata) %}

    select
        payment_type,
        sum(fare_amount + tip_amount + tolls_amount + extra + mta_tax) as total_fare
    from {{ source("dbt_lab", "taxi_tripdata") }}
    group by payment_type


{% endmacro %}
