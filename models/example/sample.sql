{{ config(materialized="table") }}
select *
from {{ source("dbt_lab", "raw_bank") }}
