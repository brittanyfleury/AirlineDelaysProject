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

### Sample SQL Query

This query returns the top 10 airports with the most delayed arrivals (15+ minutes):

```sql
SELECT 
  airport,
  airport_name,
  SUM(arr_del15) AS total_delayed_flights_15min_plus
FROM delays_cleaned
GROUP BY airport, airport_name
ORDER BY total_delayed_flights_15min_plus DESC
LIMIT 10;
```

## 📈 Dashboard Highlights

- **Top 5 Delay-Prone Airports**: Bar chart showing which airports have the highest percentage of delayed arrivals.
- **Delay Trends by Month and Season**: Line chart visuals to highlight patterns over time.
- **Disruption Causes Breakdown**: Pie chart detailing delays caused by weather, NAS, security, and late aircraft.
- **Carrier Performance Comparison**: Visuals comparing delay rates by airline.
- **Interactive Filters**: Dashboard slicers for year, month, airport, carrier, and delay type for customized exploration.


## 📚 What I Learned

- Practiced data cleaning and wrangling in Python using Pandas library
- Strengthened ability to write advanced SQL queries to analyze real-world business problems  
- Applied time-series feature engineering to support seasonal and trend analysis  
- Developed an end-to-end data pipeline from raw CSVs to an interactive BI dashboard  
- Gained practical experience presenting insights visually to support decision-making  

---

## 🚀 Future Improvements

- Build a machine learning model to predict flight delays based on historical patterns  
- Improve dashboard responsiveness for mobile viewing and embedded use
- Create another dashboard using Tableau
