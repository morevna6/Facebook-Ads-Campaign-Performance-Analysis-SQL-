# Facebook Ads Campaign Performance Analysis (SQL)

## Project Overview
This project analyzes Facebook Ads campaign performance using SQL and key digital marketing KPIs.

The analysis focuses on campaign efficiency, engagement, and return on investment by calculating core metrics from raw advertising data.

---

## 🗂 Dataset
- `facebook_ads_basic_daily`

---

## Analysis Tasks

### 1. Daily Campaign Performance
This query groups advertising data by date and campaign to calculate:

- Total spend
- Total impressions
- Total clicks
- Total conversion value
- CPC (Cost Per Click)
- CPM (Cost Per 1000 Impressions)
- CTR (Click-Through Rate)
- ROMI (Return on Marketing Investment)

### 2. High-Spend Campaign Evaluation
A second query identifies the campaign with the highest ROMI among campaigns with total spend above 500000.

---

## SQL Query

```sql
SELECT
    ad_date,
    campaign_id,
    SUM(spend) AS total_spend,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(value) AS total_value,
    (SUM(spend)::numeric) / NULLIF(SUM(clicks)::numeric, 0) AS cpc,
    (SUM(spend)::numeric * 1000) / NULLIF(SUM(impressions)::numeric, 0) AS cpm,
    (SUM(clicks)::numeric * 100) / NULLIF(SUM(impressions)::numeric, 0) AS ctr,
    ((SUM(value)::numeric - SUM(spend)::numeric) * 100) / NULLIF(SUM(spend)::numeric, 0) AS romi
FROM facebook_ads_basic_daily
GROUP BY ad_date, campaign_id;

SELECT
    campaign_id,
    SUM(spend) AS total_spend,
    SUM(value) AS total_value,
    ((SUM(value)::numeric - SUM(spend)::numeric) * 100)
      / NULLIF(SUM(spend)::numeric, 0) AS romi
FROM facebook_ads_basic_daily
GROUP BY campaign_id
HAVING SUM(spend) > 500000
ORDER BY romi DESC
LIMIT 1;
