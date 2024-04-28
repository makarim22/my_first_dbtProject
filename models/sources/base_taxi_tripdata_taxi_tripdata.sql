with source as (
      select * from {{ source('taxi_tripdata', 'taxi_tripdata') }}
),
renamed as (
    select
        

    from source
)
select * from renamed
  