-- Define a model named order_satisfaction
WITH o as (
    select *
    from {{ ref('stg_orders')}}
),
l as (
    select *
    from {{ ref('stg_lineitem')}}
),



late_deliveries AS (
    -- Subquery to identify orders with late deliveries within the specified period
    SELECT
        o.orderkey,
        o.orderpriority
    FROM
        o
    JOIN
        l ON o.orderkey = l.orderkey
    WHERE
        YEAR(o.orderdate) = 1993
        AND QUARTER(o.orderdate) IN (1, 2)
        AND l.commitdate < l.receiptdate
),
order_priority_counts AS (
    -- Subquery to count the number of orders with late deliveries for each order priority
    SELECT
        o.orderpriority,
        COUNT(ld.orderkey) AS late_delivery_count
    FROM
        o
    LEFT JOIN
        late_deliveries AS ld ON o.orderkey = ld.orderkey
    GROUP BY
        o.orderpriority
    ORDER BY
        o.orderpriority
)
-- Final query to display the count of orders with late deliveries for each order priority
SELECT
    opc.orderpriority,
    COALESCE(opc.late_delivery_count, 0) AS late_delivery_count
FROM
    (
        SELECT DISTINCT orderpriority FROM o
    ) AS all_priorities
LEFT JOIN
    order_priority_counts AS opc ON all_priorities.orderpriority = opc.orderpriority
ORDER BY
    opc.orderpriority