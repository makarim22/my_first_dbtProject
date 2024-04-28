{{
    config(
        materialized="table",
    )
}}

select *
from {{ source("austin_bikeshare", "bikeshare_stations") }}
where status = 'active'
