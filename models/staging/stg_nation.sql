with cte as (
    select n_nationkey as nationkey,
    n_name as nationname
    from snowflake_sample_data.TPCH_SF1000.nation
)

select *
from cte