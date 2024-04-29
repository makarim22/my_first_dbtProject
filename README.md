Welcome to your new dbt project!

Alur pengerjaan:
1. masukkan file csv ke folder dbt seed lalu jalankan dbt seeds
2. tabel akan otomatis digenerate pada database bigquery yang terhubung dengan dbt project.
   preview tabel raw :

   <img width="953" alt="image" src="https://github.com/makarim22/my_first_dbtProject/assets/97607349/9ffe280f-b5f3-4b0b-9a01-6b6031c0569a">

4. define tabel tersebut pada dbt project sehingga dapat direfer pada eksekusi model selanjutnya. caranya dadalah dengan menggunakan template sebagai berikut dengan menyesuaikannya dengan tabel bersangkutan.
   version: 2

sources:
  - name: jaffle_shop
    description: This is a replica of the Postgres database used by our app
    tables:
      - name: orders
        description: >
          One record per order. Includes cancelled and deleted orders.
        columns:
          - name: id
            description: Primary key of the orders table
            tests:
              - unique
              - not_null
          - name: status
            description: Note that the status can change over time

      - name: ...

  - name: ...

    adapun konfigurasi yml berada pada taxi_trip.yml

4. buat model sql sebagaimana pada soal yaitu :
   - monthly passenger :
   - monthly transaction per payment type :
   - monthly trip distance per rate code
  
5. menambahkan 2 model lainnya yaitu :
   - avg speed :
     query :
     SELECT
      EXTRACT(HOUR
     FROM
      lpep_pickup_datetime) hour,
      ROUND(AVG(trip_distance / TIMESTAMP_DIFF(lpep_dropoff_datetime,
      lpep_pickup_datetime,
      SECOND))*3600, 1) speed
     FROM
       {{ source("dbt_lab", "taxi_tripdata") }}
     WHERE
      trip_distance > 0
      AND fare_amount/trip_distance BETWEEN 2
      AND 10
      AND lpep_dropoff_datetime > lpep_pickup_datetime
    GROUP BY
     1
    ORDER BY
     1 

    ![image](https://github.com/makarim22/my_first_dbtProject/assets/97607349/1a2d7f4e-6656-4fc9-8033-2b5b591440cd)

     
   - total_charge :
   - total fare by payment_type (menggunakan macros)
     contoh query total_charge:
     SELECT
  EXTRACT(HOUR
  FROM
    lpep_pickup_datetime) hour,
  sum (congestion_surcharge) as total_surcharge
FROM
  {{ source("dbt_lab", "taxi_tripdata") }}
WHERE
  trip_distance > 0
  AND fare_amount/trip_distance BETWEEN 2
  AND 10
  AND lpep_dropoff_datetime > lpep_pickup_datetime
GROUP BY
  1
ORDER BY
  1
  dengan hasil sebagai berikut :
<img width="412" alt="image" src="https://github.com/makarim22/my_first_dbtProject/assets/97607349/b92a88a6-6da9-4665-ae36-5b9b126ab598">


adapun rumus macros yang membentuk total fare by payment_type adalah:
 {% macro total_fare_by_payment(taxi_tripdata) %}
    select
        payment_type,
        sum(fare_amount + tip_amount + tolls_amount + extra + mta_tax) as total_fare
    from {{ source("dbt_lab", "taxi_tripdata") }}
    group by payment_type
 {% endmacro %}

    
    6. melakukan generic test dan singular test
    
    generic test dilakukan dengan memberikan argumen/parameter pada masing-masing kolom yang dimaksud. ada 4 tipe generic test : unique, non-null, accepted_values, dan 
    relationships. karena dataset ini tidak memiliki primary key maka generic test unique tidak dilakukan. dengan mengacu metadata, dilakukan generic test berupa accepted 
    values pada beberapa kolom sebagai contoh kolom payment_type:
  
   <img width="479" alt="image" src="https://github.com/makarim22/my_first_dbtProject/assets/97607349/5b570b36-8fa1-41b3-b97b-db39cf8faeb1">


    
    dilakukan konfigurasi sebagai berikut :

   <img width="607" alt="image" src="https://github.com/makarim22/my_first_dbtProject/assets/97607349/fe04ce6e-81cf-48eb-80c0-c2cfba685bdf">



   
   singular test merupakan tes custom pada beberapa kolom. caranya adalah dengan membuat model baru (.sql) dan memanggil command dbt test --select <nama file>
   contoh query :
   -- Test name: test_fare_amount_positive

   SELECT 
   COUNT(*) AS invalid_rows,
   CASE WHEN fare_amount < 0 THEN 'Invalid: Negative fare amount' ELSE NULL END AS assertion_result
   FROM {{source('taxi_trip',"taxi_tripdata")}}
   group by assertion_result
   
   7. melakukan insert kolom baru berupa jumlah dalam rupiah dengan membuat model berikut :

   SELECT
   *,  -- Select all existing columns
   ROUND(total_amount * 16241.5, 2) AS total_amount_idr  -- Add converted amount with rounding
   FROM {{ source("dbt_lab", "taxi_tripdata") }}

   catatan : semua model dibentuk dalam tampilan view, tiap model dilakukan run sqlfmt 
 





 
