with o as(
    select *
    from {{ ref('stg_orders')}}
),
c as (
    select *
    from {{ ref('stg_customer')}}
),
l as (
    select *
    from {{ ref('stg_lineitem')}}
),
customer_orders AS (
    SELECT
        c.custkey,
        COALESCE(SUM(l.extendedprice), 0) AS total_order_value
    FROM
        c
    LEFT JOIN
        o USING (custkey)
    LEFT JOIN
        l USING (orderkey)
    WHERE 
        o.comment NOT LIKE '%special%'
    GROUP BY
        c.custkey
    
)

SELECT
    co.custkey as customer,
    co.total_order_value
FROM
    customer_orders AS co
ORDER BY
    total_order_value DESC