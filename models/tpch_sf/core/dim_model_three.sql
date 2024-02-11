-- Model 3: Analyzing customer orders excluding special orders
with
    o as (select * from {{ ref("stg_orders") }}),
    c as (select * from {{ ref("stg_customer") }}),
    l as (select * from {{ ref("stg_lineitem") }}),
    customer_orders as (
        select c.custkey, coalesce(sum(l.extendedprice), 0) as total_order_value
        from c
        left join o using (custkey)
        left join l using (orderkey)
        where o.comment not like '%special%'
        group by c.custkey

    )

select co.custkey as customer, co.total_order_value
from customer_orders as co
order by total_order_value desc
