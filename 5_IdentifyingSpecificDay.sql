
-- Query 5: Build a query for answering:
-- On what day did the total number of deaths cross 10000 in Italy? 
-- The query should return the date in the format : yyyy-mm-dd.

SELECT date
FROM `bigquery-public-data.covid19_open_data.covid19_open_data` 
where country_name="Italy" and cumulative_deceased>10000
order by date asc
limit 1


