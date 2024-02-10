with c as (
    select *
    from {{ ref('stg_customer')}}
),
o as (
    select *
    from {{ ref('stg_orders')}}
),
total_price as (select c.name as customer, o.orderdate as orderdate, sum(o.totalprice) as totalprice
from c
join o using (custkey)
group by c.name, o.orderdate
)

select customer, orderdate, totalprice, CASE WHEN totalprice > lag(totalprice, 1) OVER (partition by customer order by orderdate) THEN true
            ELSE false END AS has_total_price_increased
from total_price