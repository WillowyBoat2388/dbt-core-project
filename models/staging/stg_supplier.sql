with cte as (
    select s_suppkey as suppkey,
    s_nationkey as nationkey
    from snowflake_sample_data.TPCH_SF1000.supplier
)

select *
from cte