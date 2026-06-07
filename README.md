# Are We Wasting Our Marketing Budget on the Wrong Customers?
## A Customer Segmentation Analysis Using RFM

### Business Problem
A growing e-commerce company is spending marketing budget 
without knowing which customers are worth targeting. 
This analysis segments all customers into groups based on 
how recently they bought, how often they buy, and how much 
they spend — so the business can target the right people 
with the right message.

### Core Question
> "Are we wasting our marketing budget on the wrong customers?"

### Key Findings
- **Only 109 Champions exist** — 0.12% of customers are 
  truly loyal high-value buyers
- **Loyal Customers generate 31% of revenue** despite being 
  only 16% of customers — but they haven't bought in 388 days
- **24.85% of customers are At Risk** — nearly 1 in 4 is 
  slipping away
- **Big Spenders buy once and disappear** — high value, 
  single purchase, perfect re-engagement target

### Marketing Priority
| Priority | Segment | Customers | Action |
|---|---|---|---|
| 1 | Champions | 109 | VIP Program |
| 2 | Loyal Customers | 15,191 | Win-back campaign |
| 3 | Big Spenders | 3,124 | Re-engagement |
| 4 | Potential Loyalists | 24,814 | Loyalty program |
| 5 | New Customers | 12,075 | 30-day onboarding |
| 6 | At Risk | 23,203 | Urgent win-back |

### Tools & Architecture
- **SQL Server** — RFM calculation and segmentation
- **Power BI** — Segment visualization dashboard
- **draw.io** — Project planning diagrams

### Dataset
Olist Brazilian E-Commerce Dataset (Kaggle) — 100,000+ orders

### SQL Scripts
| Script | Purpose |
|---|---|
| 01_data_exploration.sql | Verify data and define RFM rules |
| 02_rfm_setup.sql | Create RFM schema and tables |
| 03_rfm_calculation.sql | Calculate R, F, M scores using NTILE |
| 04_customer_segmentation.sql | Assign segment labels |
| 05_rfm_insights.sql | Revenue concentration and marketing matrix |

### Project Structure
├── sql/                     # 5 SQL scripts
├── documentation/           # BRD, analysis narrative, diagrams
└── visuals/                 # Dashboard screenshot
### Dashboard Preview
![Dashboard] (visuals/dashboard_screenshot.png)

 ### Author
**Saeed Ahmad** — Aspiring E-Commerce Data Analyst
GitHub: https://github.com/saeedfreelance296-hash
