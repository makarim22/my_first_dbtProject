with source as (
      select * from {{ source('taxi_tripdata', 'taxi_tripdata_v2') }}
),
renamed as (
    select
        

    from source
)
select * from renamed
  