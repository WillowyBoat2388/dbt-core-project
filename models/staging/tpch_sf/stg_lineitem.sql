WITH cte as (
    select l_partkey as partkey,
    l_suppkey as suppkey,
    l_shipdate as shipdate
    from {{ source('tpch_sf1000', 'lineitem') }}
)

select *
from cte