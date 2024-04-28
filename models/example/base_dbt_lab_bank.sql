with
source as (select * from {{ source("dbt_lab", "raw_bank") }}),

renamed as (
    select
        {{ adapter.quote("age") }},
        {{ adapter.quote("job") }},
        {{ adapter.quote("marital") }},
        {{ adapter.quote("education") }},
        {{ adapter.quote("default") }},
        {{ adapter.quote("balance") }},
        {{ adapter.quote("housing") }},
        {{ adapter.quote("loan") }},
        {{ adapter.quote("contact") }},
        {{ adapter.quote("day") }},
        {{ adapter.quote("month") }},
        {{ adapter.quote("duration") }},
        {{ adapter.quote("campaign") }},
        {{ adapter.quote("pdays") }},
        {{ adapter.quote("previous") }},
        {{ adapter.quote("poutcome") }},
        {{ adapter.quote("deposit") }}

    from source
)

select *
from renamed
