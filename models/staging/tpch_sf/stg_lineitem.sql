WITH cte as (
    select l_partkey as partkey,
    l_suppkey as suppkey,
    l_orderkey as orderkey,
    l_shipdate as shipdate,
    l_extendedprice as extendedprice,
    l_returnflag as returnflag,
    l_discount as discount,
    l_linestatus as linestatus
    from {{ source('tpch_sf1000', 'lineitem') }}
)

select *
from cte