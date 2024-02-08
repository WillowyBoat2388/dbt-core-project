with cte as (
    select s_suppkey as suppkey,
    s_nationkey as nationkey
    from {{ source('tpch_sf1000', 'supplier') }}
)

select *
from cte