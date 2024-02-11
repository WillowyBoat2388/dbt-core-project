select
    o_orderkey as orderkey,
    o_custkey as custkey,
    o_totalprice as totalprice,
    o_orderdate as orderdate,
    o_orderpriority as orderpriority,
    o_comment as comment
from {{ source("tpch_sf1000", "orders") }}
