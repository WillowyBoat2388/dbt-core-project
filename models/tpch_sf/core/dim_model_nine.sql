--Model 9: Analyzing percentage change in total price by customer
with
    c as (select * from {{ ref("stg_customer") }}),
    o as (select * from {{ ref("stg_orders") }}),
    total_price as (
        select
            c.name as customer,
            o.orderdate as orderdate,
            sum(o.totalprice) as totalprice
        from c
        join o using (custkey)
        group by c.name, o.orderdate
    ),
    prev_price as (
        select
            customer,
            orderdate,
            totalprice,
            sum(totalprice) over (
                partition by customer
                order by orderdate
                rows between unbounded preceding and 1 preceding
            ) as prev_total_price
        from total_price
    ),
    price_change as (
        select
            customer,
            orderdate,
            totalprice,
            prev_total_price,
            round(
                (
                    (
                        totalprice - lag(totalprice, 1) over (
                            partition by customer order by orderdate
                        )
                    )
                    / prev_total_price
                )
                * 100,
                2
            ) as price_change_percentage
        from prev_price
    )

select *
from price_change
