-- Model 4: Exported model showing top 10 orders with the highest total price in the first quarter of 1995
with
    o as (select * from {{ ref("stg_orders") }}),
    l as (select * from {{ ref("stg_lineitem") }})

select distinct (o.orderkey), o.totalprice
from o
inner join l using (orderkey)
where year(o.orderdate) = '1995' and quarter(o.orderdate) = '1' and l.linestatus = 'F'
order by o.totalprice desc
limit 10
