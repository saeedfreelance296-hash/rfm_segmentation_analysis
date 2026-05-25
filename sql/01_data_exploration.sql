--================================================================================================================================
-- PROJECT : RFM SEGMENTATION ANALYSIS
-- Phase 01 : Data Exploratio And Business Understanding
--=================================================================================================

USE OlistDW
GO
-- STEP 01 : Verify Silver Tables Exist
SELECT 'silver.customers'   AS table_name, COUNT(*)  AS rows FROM silver.customers
UNION ALL
SELECT 'silver.orders',                    COUNT(*) FROM silver.orders
UNION ALL 
SELECT 'silver.order_payments',            COUNT(*) FROM silver.order_payments
UNION ALL 
SELECT 'silver.order_items',               COUNT(*) FROM silver.order_items;

-- STEP 02 : Confirm Data Range For RFM Analysis
SELECT
MIN(order_purchase_timestamp) AS earliest_order,
MAx(order_purchase_timestamp) AS latest_order,
DATEDIFF(MONTH,
        MIN(order_purchase_timestamp),
        MAx(order_purchase_timestamp)) months_of_data
FROM silver.orders;

-- STEP 03 : Understad Customer ID vs Unique ID 
SELECT
    COUNT(DISTINCT customer_id) AS total_customer_ids,
    COUNT(DISTINCT customer_unique_id) AS unique_customer_ids,
    COUNT(DISTINCT customer_id) - COUNT(DISTINCT customer_unique_id) AS difference
FROM silver.customers;

-- STEP 04 : verfiy payment data quality
SELECT
    COUNT(*)  AS total_payments,
    COUNT(DISTINCT order_id) AS unique_orders,
    SUM(payment_value) AS total_revenue,
    AVG(payment_value) AS avg_payment,
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment
FROM silver.order_payments;

-- STEP 05 : Investigating Zero payment values
SELECT
    payment_type,
    COUNT(*) AS count,
    SUM(payment_value) AS total_value
FROM silver.order_payments
WHERE payment_value = 0
GROUP BY payment_type
ORDER BY [count] DESC;