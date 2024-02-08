with o as (
    select *
    from {{ ref("stg_orders")}}
),
l as (
    select *
    from {{ ref("stg_lineitem")}}
)

select distinct(o.orderkey), o.totalprice
from o
inner join l
using(orderkey)
where YEAR(o.orderdate) = '1995' AND QUARTER(o.orderdate) = '1' AND l.linestatus = 'F'
order by o.totalprice desc
limit 10