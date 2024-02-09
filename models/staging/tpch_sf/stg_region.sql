select 
    r_name as name, 
    r_regionkey as regionkey
from {{ source('tpch_sf1000', 'region') }}