-- ============================================
-- PROJECT 2: RFM SEGMENTATION
-- Phase 4: Insights & Analysis
-- ============================================

USE OlistDW;
GO

-- ============================================
-- INSIGHT 1: Revenue Concentration
-- How much revenue do top segments generate?
-- ============================================
SELECT
    segment,
    COUNT(*)                                    AS customer_count,
    CAST(SUM(monetary) AS DECIMAL(10,2))                     AS total_revenue,
    CAST(SUM(monetary) * 100.0 / 
        (SELECT SUM(monetary) 
         FROM rfm.customer_segments) AS DECIMAL (10,2))       AS revenue_pct,
    ROUND(AVG(monetary), 2)                     AS avg_revenue_per_customer
FROM rfm.customer_segments
GROUP BY segment
ORDER BY total_revenue DESC;

-- ============================================
-- INSIGHT 2: Segment Profile
-- Average RFM metrics per segment
-- ============================================
SELECT
    segment,
    COUNT(*)                        AS customer_count,
    ROUND(AVG(recency_days), 0)     AS avg_recency_days,
    ROUND(AVG(frequency), 2)        AS avg_frequency,
    ROUND(AVG(monetary), 2)         AS avg_monetary,
    ROUND(AVG(r_score), 2)          AS avg_r_score,
    ROUND(AVG(f_score), 2)          AS avg_f_score,
    ROUND(AVG(m_score), 2)          AS avg_m_score
FROM rfm.customer_segments
GROUP BY segment
ORDER BY avg_monetary DESC;

-- ============================================
-- INSIGHT 3: Marketing Priority Matrix
-- What action should be taken per segment?
-- ============================================
SELECT
    segment,
    COUNT(*)                     AS customer_count,
    ROUND(SUM(monetary), 2)      AS total_revenue,
    ROUND(AVG(monetary), 2)      AS avg_spend,
    ROUND(AVG(recency_days), 0)  AS avg_days_inactive,
    CASE
        WHEN segment = 'Champions' 
            THEN 'VIP Program — reward and retain at all costs'
        WHEN segment = 'Loyal Customers' 
            THEN 'Win-back campaign — they were loyal, bring them back'
        WHEN segment = 'Big Spenders' 
            THEN 'Re-engagement — high value, one purchase, target now'
        WHEN segment = 'Potential Loyalists' 
            THEN 'Loyalty program — incentivize second purchase'
        WHEN segment = 'New Customers' 
            THEN '30-day onboarding — prevent single purchase churn'
        WHEN segment = 'At Risk' 
            THEN 'Urgent win-back — large segment slipping away'
        WHEN segment = 'Others' 
            THEN 'Low priority — minimal marketing spend'
        ELSE 'Monitor'
    END AS recommended_action
FROM rfm.customer_segments
GROUP BY segment
ORDER BY total_revenue DESC;