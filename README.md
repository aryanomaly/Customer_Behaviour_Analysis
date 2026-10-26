# 🛍️ Customer Behaviour Analysis

End-to-end data analytics project that takes raw customer shopping data from **cleaning and exploration in Python**, through **business-question analysis in SQL**, to an **interactive Power BI dashboard**.

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat&logo=powerbi&logoColor=black)

---

## 📌 Project Overview

Understanding *who* buys, *what* they buy, and *what makes them buy more* is central to any retail business. This project analyses a customer shopping dataset to answer practical business questions around spending patterns, discounts, subscriptions, shipping preferences, product ratings and customer loyalty.

**Goal:** turn raw transactional data into clear, decision-ready insights that a marketing or retail team could act on.

---

## 🎯 Business Questions Answered

| # | Question | Where |
|---|----------|-------|
| 1 | Does average spend differ by gender? | SQL |
| 2 | Which customers used a discount and still spent more than the average purchase? | SQL |
| 3 | Which 5 products have the highest average review rating? | SQL |
| 4 | Do Express-shipping customers spend more than Standard-shipping customers? | SQL |
| 5 | How do subscribers and non-subscribers compare on customer count, average spend and total revenue? | SQL |
| 6 | Which 5 products rely most heavily on discounts (% of purchases with a discount)? | SQL |
| 7 | How many customers are New, Returning or Loyal? | SQL (CTE + `CASE`) |
| 8 | What are the top 3 best-selling products in each category? | SQL (window function) |
| 9 | Are repeat buyers (5+ previous purchases) more likely to be subscribers? | SQL |
| 10 | Which age group contributes the most revenue? | SQL |

---

## 📂 Repository Structure

```
Customer_Behaviour_Analysis/
├── customer_shopping_behavior.csv        # Raw dataset
├── customer_shopping_analysis.ipynb      # Data cleaning & exploratory analysis (Python)
├── sql_queries.sql                       # Business analysis queries (SQL)
├── customer_behaviour_dashboard.pbix     # Interactive dashboard (Power BI)
└── README.md
```

---

## 🧰 Tech Stack

| Tool | Used for |
|------|----------|
| **Python** (pandas, Matplotlib / Seaborn, Jupyter) | Data loading, cleaning, feature preparation, EDA |
| **SQL** | Business analysis on the cleaned table (`cleaned_customer_shopping_behavior1`) |
| **Power BI** | Interactive dashboard and KPI reporting |

---

## 🔄 Workflow

1. **Data cleaning & EDA (Python)** — load the CSV, inspect and clean the data, handle missing/inconsistent values, prepare fields such as `age_group`, and explore distributions and relationships in the notebook.
2. **Load into SQL** — the cleaned dataset is stored as `cleaned_customer_shopping_behavior1`.
3. **Business analysis (SQL)** — aggregations, subqueries, CTEs, `CASE` segmentation and window functions (`ROW_NUMBER() OVER (PARTITION BY ...)`) answer the questions listed above.
4. **Dashboard (Power BI)** — key metrics and breakdowns are visualised in an interactive dashboard.

---

## 🔍 Highlights from the SQL Analysis

- **Customer segmentation** based on `previous_purchases`:
  - `New` → 1 purchase
  - `Returning` → 2 to 10 purchases
  - `Loyal` → more than 10 purchases
- **Subscriber vs non-subscriber** comparison on customer count, average spend and total revenue.
- **Discount dependence** — percentage of purchases per product that had a discount applied.
- **Top 3 products per category** using `ROW_NUMBER()` partitioned by category.
- **Revenue by age group** to see which segments drive the most sales.

<details>
<summary>Example query — top 3 products in each category</summary>

```sql
WITH item_count AS (
    SELECT category,
           item_purchased,
           COUNT(customer_id) AS item_sell,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
    FROM cleaned_customer_shopping_behavior1
    GROUP BY category, item_purchased
)
SELECT category, item_purchased, item_sell
FROM item_count
WHERE item_rank <= 3;
```

</details>

---

## 📊 Power BI Dashboard

The dashboard (`customer_behaviour_dashboard.pbix`) presents the main findings visually so they can be explored with filters and slicers.

<!-- Add a screenshot of your dashboard here, e.g.:
![Dashboard Preview](images/dashboard_preview.png)
-->

> **To open it:** download `customer_behaviour_dashboard.pbix` and open it in [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free, Windows).

---

## 💡 Key Insights

<!-- Replace these with your real findings from the notebook, SQL output and dashboard. Examples of the format: -->

- **Subscribers vs non-subscribers:** _add your finding and numbers_
- **Discounts:** _which products depend most on discounts, and does it change spend?_
- **Shipping:** _Express vs Standard average spend_
- **Loyalty:** _share of New / Returning / Loyal customers_
- **Age groups:** _which group generates the most revenue_

---

## 🚀 How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/aryanomaly/Customer_Behaviour_Analysis.git
   cd Customer_Behaviour_Analysis
   ```
2. **Python notebook**
   ```bash
   pip install pandas numpy matplotlib seaborn jupyter
   jupyter notebook customer_shopping_analysis.ipynb
   ```
3. **SQL** — load the cleaned data into your database as `cleaned_customer_shopping_behavior1`, then run `sql_queries.sql`.
4. **Power BI** — open `customer_behaviour_dashboard.pbix` in Power BI Desktop.

---

## 🔮 Possible Next Steps

- RFM (Recency, Frequency, Monetary) segmentation
- Predicting subscription likelihood or churn with a simple ML model
- Automating the pipeline from raw CSV to database refresh

---

## 👤 Author

**Aryan Thakur**
B.Tech Mechanical Engineering, Punjab Engineering College (PEC), Chandigarh

- GitHub: [@aryanomaly](https://github.com/aryanomaly)
- Email: thakuraryan500@gmail.com

⭐ If you found this project useful, consider giving it a star!
