select
    p_partkey as partkey,
    p_retailprice as sell_price,
    p_name as part_name,
    p_type as type
from {{ source("tpch_sf1000", "part") }}
