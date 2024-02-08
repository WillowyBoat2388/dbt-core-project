with cte as (
    select ps_partkey as partkey,
    ps_suppkey as suppkey,
    ps_supplycost as buyprice
    from {{ source('tpch_sf1000', 'partsupp') }}
)

select *
from cte