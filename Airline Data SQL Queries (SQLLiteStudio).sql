--Analyzing Trends in Data using SQL Queries--

--Double checking if there are any duplicates in the data (No duplciates in this dataset)
SELECT 
    *,
    COUNT(*) AS count
FROM 
    flights
GROUP BY 
    year, month, carrier, airport
HAVING 
    COUNT(*) > 1;  
    

--Business Question: Which airport has the most frequent delays?
SELECT 
  airport,
  airport_name,
  SUM(arr_del15) AS total_delayed_flights_15min_plus
FROM delays_cleaned
GROUP BY airport, airport_name
ORDER BY total_delayed_flights_15min_plus DESC
LIMIT 1 
--Answer: ORD (Chicago, IL-O'hare International Airport) has the highest amount of delays from 2013-2023.  */

--Business Question: Which airline has the longest delays (in minutes) *2013-2023?
select carrier, carrier_name, arr_delay
from delays_cleaned
group by carrier
order by arr_delay DESC
Limit 1 
--Answer: AirTran Airways Corporation (FL) has the longest delay duration (44,808 minutes total)---


--Business Question: what is the main reason for delays during the summer months for all carriers? (by number of delayed flights)--
WITH delay_sums AS (
  SELECT 
    month_year,
    season,
    SUM(carrier_ct) AS carrier_ct,
    SUM(weather_ct) AS weather_ct,
    SUM(nas_ct) AS nas_ct,
    SUM(security_ct) AS security_ct,
    SUM(late_aircraft_ct) AS late_aircraft_ct
  FROM delays_cleaned
  WHERE season = 'Summer' 
  GROUP BY month_year, season
)
SELECT 
  month_year,
  season,
  CASE
    WHEN carrier_ct >= weather_ct AND carrier_ct >= nas_ct AND carrier_ct >= security_ct AND carrier_ct >= late_aircraft_ct THEN 'Carrier'
    WHEN weather_ct >= carrier_ct AND weather_ct >= nas_ct AND weather_ct >= security_ct AND weather_ct >= late_aircraft_ct THEN 'Weather'
    WHEN nas_ct >= carrier_ct AND nas_ct >= weather_ct AND nas_ct >= security_ct AND nas_ct >= late_aircraft_ct THEN 'NAS'
    WHEN security_ct >= carrier_ct AND security_ct >= weather_ct AND security_ct >= nas_ct AND security_ct >= late_aircraft_ct THEN 'Security'
    ELSE 'Late Aircraft'
  END AS main_delay_reason
FROM delay_sums; 
---Answer: Majority of delays in the summer months are due to a late aircraft. However in 2021-2022, the main delay reason was due to a carrier delay.

--Business Question: Are there particular months where there is a general trend of greater delays in flights across all carriers?---
Select
  CAST(substr(month_year, 1, instr(month_year, '/') - 1) AS INTEGER) AS month_num,
  CASE CAST(substr(month_year, 1, instr(month_year, '/') - 1) AS INTEGER)
    WHEN 1 THEN 'January'
    WHEN 2 THEN 'February'
    WHEN 3 THEN 'March'
    WHEN 4 THEN 'April'
    WHEN 5 THEN 'May'
    WHEN 6 THEN 'June'
    WHEN 7 THEN 'July'
    WHEN 8 THEN 'August'
    WHEN 9 THEN 'September'
    WHEN 10 THEN 'October'
    WHEN 11 THEN 'November'
    WHEN 12 THEN 'December'
  END AS month_name,
  ROUND(AVG(arr_del15), 2) AS avg_arrival_delay,
  SUM(arr_del15) AS total_arrival_delay,
  COUNT(*) AS total_flights
FROM delays_cleaned
GROUP BY month_num, month_name
ORDER BY month_num; 
--Answer: August seems to have the most amount of delays. ---


---Buesinee Question: How do different airports compare when it comesto departure and arrival punctuality? Could location, traffic volume or other factors play a role?
SELECT
  airport,
  airport_name,
  SUM(arr_flights) AS total_arrivals,
  ROUND(AVG(arr_del15), 2) AS avg_num_of_delays,
  ROUND(100.0 * SUM(arr_del15) / SUM(arr_flights), 2) AS pct_delayed_15min_or_more,
  SUM(arr_cancelled) AS total_cancellations,
  SUM(arr_diverted) AS total_diversions,
  SUM(carrier_ct) AS carrier_delay_count,
  SUM(weather_ct) AS weather_delay_count,
  SUM(nas_ct) AS nas_delay_count,
  SUM(security_ct) AS security_delay_count,
  ROUND(SUM(late_aircraft_ct),2) AS late_aircraft_delay_count
FROM delays_cleaned
GROUP BY airport, airport_name
ORDER BY  pct_delayed_15min_or_more DESC; 

--Answer: Chicago's ohare Airport had the highest average number of delays. With Dallas/Fort Worth Texas (Dallas/Fort Worth International) and Atlanta, Georgia 
---(Jackson Atlanta International) following with the highest average number of delayed flights. However, these are large hubs that hae many connecting flights. 
--I also took a look at the percentage of delayed flights at each airport to account for smaller airports.Youngstown/Warren Regional Airport (Ohio) had a 100% delay rate.
---However, there were only 2 flights at this ariport. It seems like the traffic volume at each airport affects the amount of delayed flights.

---Are more routes more prone to disruptions than others?
SELECT airport_name as Arrival_Airport, route_id,
 SUM(arr_del15 + arr_cancelled + arr_diverted) AS total_disruptions, 
 ROUND(SUM((arr_del15 + arr_cancelled) + arr_diverted)/arr_flights,2) AS Disruption_Rate
FROM delays_cleaned
GROUP BY route_id
ORDER BY Disruption_Rate DESC

--Answer: Houston (IAH) routes has the highest disruption rate*/
