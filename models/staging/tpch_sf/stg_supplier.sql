select s_name as name, s_suppkey as suppkey, s_nationkey as nationkey
from {{ source("tpch_sf1000", "supplier") }}
