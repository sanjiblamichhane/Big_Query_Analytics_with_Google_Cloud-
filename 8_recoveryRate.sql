--Query 8:
-- Build a query to list the recovery rates of countries 
-- arranged in descending order (limit to 10) 
-- on the date May 10, 2020. 
-- Restrict the query to only those countries having more than 
-- 50K confirmed cases. 
-- The query needs to return the following fields: 
-- country, recovered_cases, confirmed_cases, recovery_rate.
---------------------------------------------------------------------------


WITH cases_by_country AS (
  SELECT
    country_name AS country,
    sum(cumulative_confirmed) AS cases,
    sum(cumulative_recovered) AS recovered_cases
  FROM
    bigquery-public-data.covid19_open_data.covid19_open_data
  WHERE
    date = '2020-05-10'
  GROUP BY
    country_name
 )
 
, recovered_rate AS 
(SELECT
  country, cases, recovered_cases,
  (recovered_cases * 100)/cases AS recovery_rate
FROM cases_by_country
)

SELECT country, cases AS confirmed_cases, recovered_cases, recovery_rate
FROM recovered_rate
WHERE cases > 50000
ORDER BY recovery_rate desc
LIMIT 10