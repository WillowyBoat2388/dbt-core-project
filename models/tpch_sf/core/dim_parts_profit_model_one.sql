-- Model 1: Analyzing supplier nation-wise profit for green parts

with
    p as (select * from {{ ref("stg_parts") }}),

    ps as (select * from {{ ref("stg_partsupp") }}),
    l as (select * from {{ ref("stg_lineitem") }}),
    supp as (select * from {{ ref("stg_supplier") }}),
    n as (select * from {{ ref("stg_nation") }})

select distinct
    (n.name) as supplier_nation,
    year(l.shipdate) as supply_date,
    sum(p.sell_price - ps.buyprice) as profit
from p
inner join ps using (partkey)
inner join l using (partkey, suppkey)
inner join supp using (suppkey)
inner join n using (nationkey)
where lower(p.part_name) like '%green%'
group by n.name, year(l.shipdate)
order by n.name, year(l.shipdate)
limit 10
