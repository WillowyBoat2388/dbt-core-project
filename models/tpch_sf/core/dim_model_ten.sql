-- Model 10: Analyzing if the total price has increased compared to the previous order by customer
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
    )

select
    customer,
    orderdate,
    totalprice,
    case
        when
            totalprice
            > lag(totalprice, 1) over (partition by customer order by orderdate)
        then true
        else false
    end as has_total_price_increased
from total_price
