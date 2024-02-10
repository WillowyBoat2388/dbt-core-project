with
    n as (select * from {{ ref("stg_nation") }}),
    ps as (select * from {{ ref("stg_partsupp") }}),
    s as (select * from {{ ref("stg_supplier") }}),
    o as (select * from {{ ref("stg_orders") }}),
    l as (select * from {{ ref("stg_lineitem") }})

with
    year_month as (
        select distinct
            year(o.orderdate) as the_year,
            n.name as supplier_nation,
            month(o.orderdate) as the_month,
            o.orderkey,
            sum(l.quantity) as quantity_sold
        from orders as o
        join lineitem as l using (orderkey)
        join ps using (suppkey, partkey)
        join s using (suppkey)
        join n using (nationkey)
        group by supplier_nation, the_year, the_month, orderkey
    ),
    the_rank as (
        select
            l.supplier_nation,
            l.the_year,
            l.the_month,
            dense_rank() over (
                partition by l.supplier_nation order by l.quantity_sold desc
            ) ranked
        from year_month as l
        order by supplier_nation, the_year, the_month, ranked
    )

select *
from the_rank
where ranked <= 3
