-- ============================================
-- PROJECT 2: RFM SEGMENTATION
-- Phase 2: Create RFM Schema
-- ============================================

USE OlistDW;
GO

CREATE SCHEMA rfm;
GO

-- RFM Scores Table
CREATE TABLE rfm.rfm_scores (
    customer_unique_id  VARCHAR(50),
    recency_days        INT,
    frequency           INT,
    monetary            DECIMAL(10,2),
    r_score             INT,
    f_score             INT,
    m_score             INT,
    rfm_score           VARCHAR(10)
);