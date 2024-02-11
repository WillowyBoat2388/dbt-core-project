-- Model 6: Analyzing revenue volume by nation
with
    n as (select * from {{ ref("stg_nation") }}),
    ps as (select * from {{ ref("stg_partsupp") }}),
    s as (select * from {{ ref("stg_supplier") }}),
    c as (select * from {{ ref("stg_customer") }}),
    l as (select * from {{ ref("stg_lineitem") }})

select n.name as nation, sum(l.extendedprice * (1 - l.discount)) as revenue_volume
from l
join ps using (suppkey, partkey)
join s using (suppkey)
join n using (nationkey)
join c using (nationkey)
where c.nationkey = s.nationkey
group by n.nationkey, n.name
