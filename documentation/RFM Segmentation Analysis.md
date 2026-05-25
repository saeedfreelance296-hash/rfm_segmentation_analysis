# RFM Segmentation Analysis

## Report Header

Project: RFM Customer Segmentation Analysis
Dataset: Olist Brazilian E-Commerce
Analyst: Saeed Ahmad
Date: 25 May 2026
Purpose: Segment customers by value to identify
who deserves marketing budget and who doesn't

## Business Context

The business is spending marketing budget without
knowing which customers are worth targeting.
This analysis segments all customers into groups
based on how recently they bought, how often they
buy, and how much they spend — so the business can
target the right people with the right message.

## Core Business Question

***Are we wasting our marketing budget on the wrong customers?***

## RFM Business Rules

| Metric | Definition | Source Field | Rule |
| --- | --- | --- | --- |
| Recency | Days since last delivered order | order_purchase_timestamp | Reference date = 2018-08-29 |
| Frequency | Count of distinct delivered orders | order_id | Per customer_unique_id |
| Monetary | Total payment value | payment-values | Exclude payment_value = 0 and not_defined type |

## Data Exploration Findings

| Finding | Detail | Decision |
| --- | --- | --- |
| Date range | Sep 2016 — Aug 2018, 23 months | Use 2018-08-29 as reference date |
| customer_id vs customer_unique_id | 3,345 customers have multiple IDs | Use customer_unique_id for RFM |
| Zero value payments | 9 records — voucher and not_defined | Exclude from Monetary calculation |
| Multiple payments per  order | 103,886 payments for 99,440 orders | SUM payments per order before aggregating |
| Total revenue | 16,008,872 across all orders | Baseline for Monetary scoring |

## Analytical Questions

| # | Questions | Analysis Type |
| --- | --- | --- |
| 1 | Who are our Champions — highest R, F, and M scores? | RFM Scoring |
| 2 | Which customers are At Risk of churning? | RFM Segmentation |
| 3 | How much revenue do our top 20% generate? | Revenue Concentration |
| 4 | Which segments should marketing target first? | Segment Prioritization |

## Deliverables

| Deliverable | Format | Status |
| --- | --- | --- |
| Data Exploration | .sql file | Complete |
| RFM Calculation | .sql file | Pending |
| Customer Segmentation | .sql file | Pending |
| Segment Analysis | .sql file | Pending |
| Insights Narrative | .md file | Pending |