with cte as (
    select n_nationkey as nationkey,
    n_name as name
    from {{ source('tpch_sf1000', 'nation') }}
)

select *
from cte