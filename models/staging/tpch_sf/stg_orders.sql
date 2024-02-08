with cte as (
    select o_orderkey as orderkey,
    o_custkey as custkey
    from {{ source('tpch_sf1000', 'orders') }}
)

select *
from cte