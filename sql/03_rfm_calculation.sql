--TRUNCATE TABLE rfm.rfm_scores;
-- =================================================================================================
-- PROECT 02 SEGMENTATION
-- Phase 02 RFM Calculation
-- =================================================================================================
WITH customer_order AS (
    -- Step 1: Get last order date and order count
    -- per customer_unique_id
    -- We use customer_unique_id to avoid counting
    -- the same person twice
SELECT
    c.customer_unique_id,
    MIN(o.order_purchase_timestamp) AS last_order_date,
    COUNT(o.order_id)               AS frequency
FROM silver.orders o
JOIN silver.customers c 
    ON o.customer_id = c.customer_id    
GROUP BY c.customer_unique_id
),
customer_monetary AS (
    -- Step 2: Calculate total spend per customer
    -- SUM payments per order first to handle
    -- multiple payments per order correctly
    -- Then SUM per customer

SELECT
    c.customer_unique_id,
    SUM(op.payment_value) AS monetary
FROM silver.order_payments op 
JOIN silver.orders o 
    ON op.order_id = o.order_id
JOIN silver.customers c  
    ON o.customer_id = c.customer_id
WHERE op.payment_value > 0
AND   op.payment_type <> 'not defined'
GROUP BY c.customer_unique_id
),
raw_rfm AS(

    -- Step 3: Combine recency, frequency, monetary
    -- Calculate recency as days since last order
    -- Reference date = 2018-08-29 (dataset end date)
SELECT
co.customer_unique_id,
DATEDIFF(DAY, co.last_order_date, '2018-08-29') AS recency_days,
co.frequency,
cm.monetary
FROM customer_order co    
JOIN customer_monetary cm 
    ON co.customer_unique_id = cm.customer_unique_id
),
rfm_scored AS (
    -- Step 4: Score each metric 1-5 using NTILE
    -- Recency: lower days = better = higher score
    -- Frequency: higher count = better = higher score
    -- Monetary: higher spend = better = higher score
SELECT
customer_unique_id,
recency_days,
frequency,
monetary,
 -- Lower recency days = better score
 -- So we reverse the order with DESC
6 - NTILE(5) OVER(ORDER BY recency_days ASC) AS r_score,
6 - NTILE(5) OVER(ORDER BY frequency DESC) AS f_score,
6 - NTILE(5) OVER(ORDER BY monetary DESC) AS m_score
FROM raw_rfm
)
-- Step 5: Insert into rfm.rfm_scores
INSERT INTO rfm.rfm_scores
SELECT
customer_unique_id,
recency_days,
frequency,
monetary,
r_score,
f_score,
m_score,
CONCAT(r_score, f_score, m_score) AS rfm_score
FROM rfm_scored

-- Verify 
SELECT Top 20 * FROM rfm.rfm_scores
ORDER BY rfm_score DESC

