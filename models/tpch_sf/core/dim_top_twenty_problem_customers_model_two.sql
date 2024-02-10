WITH c as (
    select *
    from {{ ref('stg_customer') }}
),
o as (
    select *
    from {{ ref('stg_orders') }}
),
l as (
    select *
    from {{ ref('stg_lineitem') }}
),
n as (
    select *
    from {{ ref('stg_nation') }}
)

SELECT DISTINCT(c.name) as customer, c.address as customer_address, n.name as nation, c.phone as customer_number, c.acctbal as customer_acct, c.comment as customer_comment, sum(l.extendedprice*(1-l.discount)) OVER (PARTITION BY c.custkey) AS lost_revenue
FROM c
inner join n using (nationkey)
inner join o using (custkey)
inner join l using (orderkey)
HAVING year(l.shipdate) = '1993' AND quarter(l.shipdate) = '3' AND l.returnflag = 'R'
ORDER BY lost_revenue DESC
LIMIT 20