with cte as (
    select n_nationkey as nationkey,
    n_name as nationname
    from {{ source('tpch_sf1000', 'nation') }}
)

select *
from cte