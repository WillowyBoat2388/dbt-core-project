WITH c as (
    select *
    from {{ ref('stg_customers') }}
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

SELECT DISTINCT(c.name), c.address, n.name, c.phone, c.acctbal, c.comment, sum(l.extendedprice*(1-l.discount)) OVER (PARTITION BY c.custkey) AS lost_revenue
FROM c
inner join n using (nationkey)
inner join o using (custkey)
inner join l using (orderkey)
HAVING year(l.shipdate) = '1993' AND quarter(l.shipdate) = '3' AND l.returnflag = 'R'
ORDER BY lost_revenue DESC
LIMIT 20