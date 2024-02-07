WITH Part AS (
    SELECT p_partkey as partkey,
    p_retailprice as sell_price
    p_name as part_name
    FROM snowflake_sample_data.TPCH_SF1000.PART
)

select * from Part
