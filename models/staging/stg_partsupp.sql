with cte as (
    select ps_partkey as partkey,
    ps_suppkey as suppkey,
    ps_supplycost as buyprice
    from snowflake_sample_data.TPCH_SF1000.partsupp
)

select *
from cte