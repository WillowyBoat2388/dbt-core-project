WITH CTE as (
    select l_partkey as partkey,
    l_suppkey as suppkey,
    l_shipdate as shipdate
    from snowflake_sample_data.TPCH_SF1000.lineitem
)

select *
from cte