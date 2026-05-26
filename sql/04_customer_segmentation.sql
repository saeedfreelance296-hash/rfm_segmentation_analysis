-- ============================================
-- PROJECT 2: RFM SEGMENTATION
-- Phase 3: Customer Segmentation
-- ============================================

USE OlistDW;
GO

-- Create segmentation table
CREATE TABLE rfm.customer_segments (
    customer_unique_id  VARCHAR(50),
    recency_days        INT,
    frequency           INT,
    monetary            DECIMAL(10,2),
    r_score             INT,
    f_score             INT,
    m_score             INT,
    rfm_score           VARCHAR(10),
    segment             VARCHAR(50)
);
GO
-- Insert with segment labels
INSERT INTO rfm.customer_segments
SELECT
    customer_unique_id,
    recency_days,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    rfm_score,
    CASE
        WHEN r_score = 5 AND f_score = 5 AND m_score = 5 
            THEN 'Champions'
        WHEN f_score >= 4 AND m_score >= 4 
            THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score >= 2 
            THEN 'Potential Loyalists'
        WHEN r_score <= 2 AND f_score >= 3 
            THEN 'At Risk'
        WHEN r_score >= 4 AND f_score = 1 
            THEN 'New Customers'
        WHEN m_score = 5 
            THEN 'Big Spenders'
        WHEN r_score = 1 AND f_score = 1 
            THEN 'Lost'
        ELSE 'Others'
    END AS segment
FROM rfm.rfm_scores;

GO
-- Verify segment distribution
SELECT
    segment,
    COUNT(*)                            AS customer_count,
    ROUND(AVG(recency_days), 0)         AS avg_recency,
    ROUND(AVG(frequency), 1)            AS avg_frequency,
    ROUND(AVG(monetary), 2)             AS avg_monetary,
    ROUND(SUM(monetary), 2)             AS total_revenue,
    ROUND(COUNT(*) * 100.0 / 
        (SELECT COUNT(*) FROM rfm.customer_segments), 2) AS pct_of_customers
FROM rfm.customer_segments
GROUP BY segment
ORDER BY total_revenue DESC;

