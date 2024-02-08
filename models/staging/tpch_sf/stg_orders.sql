with cte as (
    select o_orderkey as orderkey,
    o_custkey as custkey,
    o_totalprice as totalprice,
    o_orderdate as orderdate
    from {{ source('tpch_sf1000', 'orders') }}
)

select *
from cte