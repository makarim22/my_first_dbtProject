{{ config(materialized="table") }}
{% set profile_columns = [
    "age_group",
    "job",
    "marital",
    "education",
    "`default`",
    "housing",
    "loan",
    "deposit",
] %}
with
bank as (
    select
        *,
        case
            when age < 40
                then 'young adult'
            when age >= 40 and age < 60
                then 'middle-aged adult'
            when age >= 60
                then 'old adult'
        end as age_group
    from {{ ref("bank") }}
)

select
    {% for profile_column in profile_columns %} {{ profile_column }},
    {% endfor %}
    count(*) as jumlah_klien
from bank
group by
{% for profile_column in profile_columns %}
    {{ profile_column }} {% if not loop.last %}, {% endif %}
{% endfor %}
