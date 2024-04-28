{{ config(materialized="table") }}


select
    * except (`default`, housing, loan, `month`, deposit),
    `default` = 'yes' as `default`,
    housing = 'yes' as housing,
    loan = 'yes' as loan,
    extract(month from parse_date('%b', `month`)) as `month`,
    deposit = 'yes' as deposit
from {{ source("dbt_lab", "raw_bank") }}
