WITH p as (
    select *
    from {{ ref('stg_parts')}}
),
o as (
    select *
    from {{ ref('stg_orders')}}
),
l as (
    select *
    from {{ ref('stg_lineitem')}}
),
promotional_parts AS (
    SELECT
        l.partkey,
        DATE_TRUNC('month', o.orderdate) AS order_month
    FROM
        l
    JOIN
        p USING (partkey)
    JOIN
        o USING (orderkey) 
    WHERE
        o.orderdate >= '1995-10-01' AND o.orderdate < '1996-01-01'
        AND p.type LIKE '%PROMO%'
        AND l.shipdate >= '1995-10-01' AND l.shipdate < '1996-01-01'
),
total_revenue AS (
    SELECT
        DATE_TRUNC('month', o.orderdate) AS order_month,
        SUM(l.extendedprice * (1 - l.discount)) AS total_revenue
    FROM
        l
    JOIN
        o USING (orderkey)
    WHERE
        o.orderdate >= '1995-10-01' AND o.orderdate < '1996-01-01'
    GROUP BY
        order_month
),
promotional_revenue AS (
    SELECT
        pp.order_month,
        SUM(l.extendedprice * (1 - l.discount)) AS promotional_revenue
    FROM
        l
    JOIN
        promotional_parts AS pp ON l.partkey = pp.partkey
    GROUP BY
        pp.order_month
)


SELECT
    tr.order_month,
    pr.promotional_revenue / tr.total_revenue AS percentage_revenue_from_promotional_parts
FROM
    total_revenue AS tr
JOIN
    promotional_revenue AS pr ON tr.order_month = pr.order_month
ORDER BY
    tr.order_month