-- Query 3: Identifying Hotspots
-- Build a query that will answer
-- "List all the states in the United States of America that had more than 1000 confirmed cases on Apr 10, 2020?" 
-- The query needs to return the State Name and the corresponding confirmed cases arranged in descending order.
--  Name of the fields to return state and total_confirmed_cases.

---------------------------------------------------------------------------
SELECT * FROM (
-- create a query that will select based on total confirmed cases
-- FIND TOTAL CONFIRMED CASES
	SELECT subregion1_name as state,
		sum(cumulative_confirmed) as total_confirmed_cases

		FROM bigquery-public-data.covid19_open_data.covid19_open_data


			WHERE country_code = "US" AND date = '2020-04-10'
				AND subregion1_name is NOT NULL
					GROUP BY subregion1_name
						ORDER BY total_confirmed_cases DESC 
						
) WHERE total_confirmed_cases > 1000