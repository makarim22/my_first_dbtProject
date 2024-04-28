with
source as (
    select * from {{ source("austin_bikeshare", "bikeshare_stations") }}
),

renamed as (
    select
        {{ adapter.quote("station_id") }},
        {{ adapter.quote("name") }},
        {{ adapter.quote("status") }},
        {{ adapter.quote("address") }},
        {{ adapter.quote("alternate_name") }},
        {{ adapter.quote("city_asset_number") }},
        {{ adapter.quote("property_type") }},
        {{ adapter.quote("number_of_docks") }},
        {{ adapter.quote("power_type") }},
        {{ adapter.quote("footprint_length") }},
        {{ adapter.quote("footprint_width") }},
        {{ adapter.quote("notes") }},
        {{ adapter.quote("council_district") }},
        {{ adapter.quote("modified_date") }}

    from source
)

select *
from renamed
