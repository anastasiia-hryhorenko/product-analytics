# Product Analytics: Cohort-Based User Retention Metrics

## 📊 Project Overview
This product analytics project focuses on evaluating and analyzing **User Retention (Retention Rate)** 
using **Cohort Analysis**. The core objective is to understand user engagement over time and perform a comparative 
analysis of retention dynamics between two major user segments: **Organic Users** versus users acquired via promotional 
campaigns (**Promo Users**). 

By leveraging **SQL** for heavy data lifting and **Google Sheets** for reporting, this project builds an end-to-end analytics 
workflow—from raw database transactions to actionable business insights that help optimize marketing spend and improve acquisition 
quality.

---

## 📈 Live Dashboards & Code
* 📊 **Interactive Cohort Model:** [Open in Google Sheets](https://docs.google.com/spreadsheets/d/1YJC6jdDvOum5U468yGxbL0KVhZ9ui4A5ulUODn0nQEE/edit?gid=1431524392#gid=1431524392) 
* 💾 **Data Transformation Script:** [Product Analytics.sql]

---

## 🛠 Tech Stack & Tools
* **SQL:** Data extraction, multi-table joins, data cleaning, filtering, and structuring raw transaction logs.
* **Google Sheets:** Pivot tables, advanced formulas, conditional formatting, and cohort heatmaps.
* **Methodology:** Cohort Analysis, Customer Lifecycle Segmentation, Acquisition Channel Analysis (Organic vs. Promo).

---

## 🔑 Key Responsibilities & Workflow

### 1. Data Extraction & Transformation (SQL)
* Wrote optimized SQL queries to extract data from raw transaction and user activity logs.
* Performed data cleaning (handled missing values, filtered out test entries).
* Calculated critical customer lifecycle milestones, including each user's exact acquisition date (Cohort ID)
* and subsequent activity intervals (Lifetime Months).

### 2. Analytical Modeling (Google Sheets)
* Built structured, dynamic cohort grids and matrix tables using extracted database outputs.
* Calculated and aggregated **Retention Rates** month-over-month.
* Applied **Conditional Formatting** to design professional, easy-to-read cohort heatmaps, making visualization
*  of user drop-offs instantly recognizable.

### 3. Comparative & Channel Analysis
* Segmented the user base into **Organic Users** and **Promo Users**.
* Compared behavioral retention trends across these channels to evaluate long-term loyalty versus short-term promotional spikes.

---

## 💡 Key Analytical Findings & Conclusions
Based on the cohort analysis conducted within Google Sheets and SQL, several critical product and marketing insights were uncovered:

### 1. General Retention Trends & Cohort Volume
* **High Initial Engagement:** The product demonstrates a strong baseline retention in the first month. Across almost all cohorts,
* the **Month 1 Retention Rate stands at approximately 70%**, meaning that nearly 70% of registered users actively return to the
* product after their initial sign-up.
* **Stable Cohort Volume:** The acquisition volume remains highly consistent, averaging around **100 new users per month**.
* March serves as the only minor exception, showing a slight decrease with 82 new users acquired.
* **Natural Lifecycle Decline:** As user lifecycle progresses, engagement gradually decreases month-over-month.
* The lowest point is observed in **Month 5, where the average Retention Rate drops to 40%**.

### 2. Deep Dive: Organic vs. Promotional Traffic Performance
The comparative analysis between acquisition channels reveals a significant disparity in user quality and long-term loyalty:
* **Organic Channel Dominance:** Organic acquisition significantly outperforms promotional campaigns in both initial volume
* and long-term user retention.
* **The "Promo Drop-off" Effect:** Users acquired via promotional campaigns suffer a severe drop-off over time. By
* **Month 5,Promo Retention plummets to a critical 9%**. 


### 🎯 Strategic Business Recommendations
* **Optimize Marketing Budget:** Promotional campaigns underperform significantly compared to organic growth. The business
* should critically review the current promo mechanisms (discounts, bonuses) as they attract low-intent users who churn quickly. 
* **Shift to Organic Growth:** It is highly recommended to reallocate marketing spend toward organic acquisition channels, SEO,
* and product-led growth strategies, as organic users yield substantially higher Lifetime Value (LTV) and long-term retention.
---

## 📁 How to Review This Project
1. Open the [Product Analytics.sql] to review code structure, query optimization, and data aggregation logic.
2. Open the [Google Sheets link](https://docs.google.com/spreadsheets/d/1YJC6jdDvOum5U468yGxbL0KVhZ9ui4A5ulUODn0nQEE/edit?gid=1431524392#gid=1431524392)
* to explore the interactive cohort models, pivot tables, formulas, and visual heatmaps.
