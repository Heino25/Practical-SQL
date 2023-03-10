-- 12 Try it yourself
--1 Here are two tasks to help you become more familiar with the concepts introduced in the chapter:
--1.Revise the code in Listing 12-15 to dig deeper into the nuances of Waikiki’s 
--high temperatures. Limit the temps_collapsed table to the Waikiki maximum 
--daily temperature observations. Then use the WHEN clauses in the CASE statement to reclassify the temperatures into seven groups that would result in 
--the following text output:
--'90 or more'
--'88-89'
--'86-87'
--'84-85'
--'82-83'
--'80-81'
--'79 or less'

 WITH temps_collapsed (station_name, max_temperature_group) AS
 
 	(SELECT station_name,
 		CASE WHEN max_temp >= 90 THEN '90 or more'
	 		 WHEN max_temp BETWEEN 88 AND 89 THEN '88-89'
	 		 WHEN max_temp BETWEEN 86 AND 87 THEN '86-87'
	 		 WHEN max_temp BETWEEN 84 AND 85 THEN '84-85'
	 		 WHEN max_temp BETWEEN 82 AND 83 THEN '82-83'
	 		 WHEN max_temp BETWEEN 80 AND 81 THEN '80-81'
	 		 WHEN max_temp <= 79 THEN '79 or less'
 		END
    FROM temperature_readings
    WHERE station_name = 'WAIKIKI 717.2 HI US')

SELECT station_name, max_temperature_group
FROM temps_collapsed
GROUP BY station_name, max_temperature_group
ORDER BY max_temperature_group DESC;

--2
-- Revise the ice cream survey crosstab in Listing 12-11 to flip the table. In other words, make flavor the rows and office the columns. Which elements of the query do you need to change? Are the counts different?

SELECT *
 FROM crosstab('SELECT flavor, office, count(*)
 FROM ice_cream_survey
 GROUP BY flavor, office
 ORDER BY flavor',
 
 'SELECT office
 FROM ice_cream_survey
 GROUP BY office
 ORDER BY office')
				
 AS (office varchar(20),
 Downtown bigint,
 Midtown bigint,
 vanilla bigint);

