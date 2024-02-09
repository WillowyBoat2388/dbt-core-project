select c_custkey as custkey,
    c_nationkey as nationkey,
    c_name as name,
    c_address as address,
    c_phone as phone,
    c_acctbal as acctbal,
    c_comment as comment
from {{ source('tpch_sf1000', 'customer') }}