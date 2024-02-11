-- Model 2: Analyzing lost revenue due to returns for the third quarter of 1993
with
    c as (select * from {{ ref("stg_customer") }}),
    o as (select * from {{ ref("stg_orders") }}),
    l as (select * from {{ ref("stg_lineitem") }}),
    n as (select * from {{ ref("stg_nation") }})

select distinct
    (c.name) as customer,
    c.address as customer_address,
    n.name as nation,
    c.phone as customer_number,
    c.acctbal as customer_acct,
    c.comment as customer_comment,
    sum(l.extendedprice * (1 - l.discount)) over (
        partition by c.custkey
    ) as lost_revenue
from c
inner join n using (nationkey)
inner join o using (custkey)
inner join l using (orderkey)
having year(l.shipdate) = '1993' and quarter(l.shipdate) = '3' and l.returnflag = 'R'
order by lost_revenue desc
