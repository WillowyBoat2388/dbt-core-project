select s_partkey as partkey, s_suppkey as suppkey, s_nationkey as nationkey
from {{ source("tpch_sf1000", "supplier") }}
