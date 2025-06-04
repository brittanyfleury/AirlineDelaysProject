# AirlineDelaysProject

# ✈️ Airline Delay Analysis Dashboard (2013–2023)

This project analyzes 10 years of U.S. flight delay data (2013–2023) to uncover trends, causes, and patterns affecting airline punctuality. Using **Python**, **SQL**, and **Power BI**, I cleaned and transformed the raw data, ran exploratory and analytical queries, and built a fully interactive dashboard for strategic insight.

---

## 📊 Project Goals

- Understand which **airports and carriers** experience the most delays.
- Identify **seasonal trends** in delays and cancellations.
- Determine **root causes** of disruptions (e.g., late aircraft, weather, NAS).
- Predict likelihood of delays using historical data and engineered features.
- Visualize key metrics for stakeholders in an interactive dashboard.

---

## 🧰 Tools Used

| Tool           | Purpose                              |
|----------------|-------------------------------------|
| Python (Pandas) | Data cleaning, feature engineering  |
| SQLite (SQL)    | Querying trends, aggregations, answer business questions |
| Power BI       | Visualization & dashboard building   |

---

## 🔨 Process Overview

### 1. Data Cleaning & Feature Engineering (Python)

- Loaded and inspected CSV dataset from [Kaggle](https://www.kaggle.com/datasets/sriharshaeedala/airline-delay/data)
- Handled missing values
- Created new features:
  - `season` (from `month`)
  - `route_id` = origin → destination
  - `delay_rate`, `cancel_rate`, `divert_rate` (normalized disruption metrics)
  - `month_year` as time-series identifier
- Exported clean dataset for analysis in SQLite and Power BI

### 2. Data Analysis (SQL)

- Identified:
  - **Most delay-prone airports and carriers**
  - **Disruption rates by month and season**
  - **Top delay reasons per airport/season**

- Sample Query:
```sql
SELECT 
  airport,
  airport_name,
  SUM(arr_del15) AS total_delayed_flights_15min_plus
FROM delays_cleaned
GROUP BY airport, airport_name
ORDER BY total_delayed_flights_15min_plus DESC
LIMIT 1;

