--Query 7: Using the previous query as a template,
--  write a query to find out the dates on which the confirmed cases 
-- increased by more than 10% compared to the previous day 
-- (indicating a doubling rate of ~ 7 days) 
-- in the US between the dates March 22, 2020 and April 20, 2020. 
-- The query needs to return the list of dates, 
-- the confirmed cases on that day, the confirmed cases 
-- the previous day and the percentage increase in cases between 
-- the days. Use the following names for the returned fields: 
-- Date, Confirmed_Cases_On_Day, Confirmed_Cases_Previous_Day 
-- and Percentage_Increase_In_Cases.
-------------------------------------------------------------------


WITH us_cases_by_date AS (
  SELECT
    date,
    SUM(cumulative_confirmed) AS cases
  FROM
    `bigquery-public-data.covid19_open_data.covid19_open_data`
  WHERE
    country_name="United States of America"
    AND date between '2020-03-22' and '2020-04-20'
  GROUP BY
    date
  ORDER BY
    date ASC 
 )
 
, us_previous_day_comparison AS 
(SELECT
  date,
  cases,
  LAG(cases) OVER(ORDER BY date) AS previous_day,
  cases - LAG(cases) OVER(ORDER BY date) AS net_new_cases,
  (cases - LAG(cases) OVER(ORDER BY date))*100/LAG(cases) OVER(ORDER BY date) AS percentage_increase
FROM us_cases_by_date
)

select Date, cases as Confirmed_Cases_On_Day, previous_day as Confirmed_Cases_Previous_Day, percentage_increase as Percentage_Increase_In_Cases
from us_previous_day_comparison
where percentage_increase > 10
