WITH p as (
    select *
    from {{ ref('stg_parts') }}
),

ps as (
    select *
    from {{ ref('stg_partsupp') }}
),
l as (
    select *
    from {{ ref('stg_lineitem') }}
),
supp as (
    select *
    from {{ ref('stg_supplier') }}
),
n as (
    select *
    from {{ ref('stg_nation') }}
)


select distinct(n.nationname) AS SUPPLIER_NATION, YEAR(L.shipdate) AS SUPPLY_DATE, SUM(P.sell_price-PS.buyprice) AS PROFIT
from p 
INNER JOIN ps using (partkey)
inner join l using (partkey, suppkey)
inner join supp using (suppkey)
inner join n using (nationkey)
where lower(p.part_name) like '%green%'
group by n.nationname, year(l.shipdate)
order by n.nationname, year(l.shipdate)
limit 10