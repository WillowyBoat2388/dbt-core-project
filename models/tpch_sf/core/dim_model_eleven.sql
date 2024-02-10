with
    p as (select * from {{ ref("stg_parts") }}),
    o as (select * from {{ ref("stg_orders") }}),
    l as (select * from {{ ref("stg_lineitem") }}),
    promotional_parts as (
        select l.partkey, date_trunc('month', o.orderdate) as order_month
        from l
        join p using (partkey)
        join o using (orderkey)
        where
            o.orderdate >= '1995-10-01'
            and o.orderdate < '1996-01-01'
            and p.type like '%PROMO%'
            and l.shipdate >= '1995-10-01'
            and l.shipdate < '1996-01-01'
    ),
    total_revenue as (
        select
            date_trunc('month', o.orderdate) as order_month,
            sum(l.extendedprice * (1 - l.discount)) as total_revenue
        from l
        join o using (orderkey)
        where o.orderdate >= '1995-10-01' and o.orderdate < '1996-01-01'
        group by order_month
    ),
    promotional_revenue as (
        select
            pp.order_month,
            sum(l.extendedprice * (1 - l.discount)) as promotional_revenue
        from l
        join promotional_parts as pp on l.partkey = pp.partkey
        group by pp.order_month
    )

select
    tr.order_month,
    pr.promotional_revenue
    / tr.total_revenue as percentage_revenue_from_promotional_parts
from total_revenue as tr
join promotional_revenue as pr on tr.order_month = pr.order_month
order by tr.order_month
