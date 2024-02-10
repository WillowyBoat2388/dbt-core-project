with
    n as (select * from {{ ref("stg_nation") }}),
    c as (select * from {{ ref("stg_customer") }}),
    o as (select * from {{ ref("stg_orders") }}),
    total_price as (
        select
            n.name as nation,
            c.name as customer,
            o.orderdate as orderdate,
            sum(o.totalprice) as totalprice
        from c
        join n using (nationkey)
        join o using (custkey)
        group by n.name, c.name, o.orderdate
    )
select
    nation,
    customer,
    orderdate,
    totalprice,
    round(
        sum(totalprice) over (
            partition by nation, customer
            order by orderdate
            rows between unbounded preceding and current row
        ),
        2
    ) as running_total_price
from total_price
