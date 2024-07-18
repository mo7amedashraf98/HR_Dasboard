
-- Age Distribution accross different departments (Employees of all time)
SELECT 
	department,
	age_group,
	COUNT(age_group) AS Count_age_group
FROM HR_data
GROUP BY department, age_group
ORDER BY department, age_group

----------------------------------------------------------------------------------------------

--Gender Distribution across departments (Employees of all time)

SELECT 
	department,
	gender, 
	COUNT(*) AS count
FROM HR_data
GROUP BY department, gender
ORDER BY department
----------------------------------------------------------------------------------------------
-- Turnover rate by department

WITH department_counts AS (
	SELECT 
		department,
		turnover_rate,
		COUNT(*) as total_Count, 
		SUM(CASE 
				WHEN TRY_CONVERT(DATE, LEFT(termdate,10)) IS NOT NULL AND TRY_CONVERT(DATE, LEFT(termdate,10)) <= CAST(GETDATE() AS DATE) THEN 1 ELSE 0
			END) as termination_count
FROM HR_data
GROUP BY department,turnover_rate)

SELECT 
	department, 
	termination_count, 
	total_count, 
	CAST(termination_count AS float)/total_Count * 100 AS dep_turnover_rate,
	turnover_rate
FROM department_counts 
ORDER BY dep_turnover_rate DESC;


----- Troubleshooting

--SELECT 
--	termdate, 
--	LEFT(termdate,10) AS date_part
--FROM HR_data
--WHERE termdate IS NOT NULL

--SELECT 
--	termdate,
--	LEFT(termdate,10) AS date_part,
--	TRY_CONVERT(DATE,LEFT(termdate,10)) AS converted_termdate
--FROM HR_data
--WHERE termdate IS NOT NULL

----------------------------------------------------------------------------------------------

SELECT jobtitle, COUNT(jobtitle) as count_jobtitles
FROM HR_data
GROUP BY jobtitle
ORDER BY jobtitle ASC
----------------------------------------------------------------------------------------------
-- The change in the employee's count over time (based on hire and term dates)
SELECT 
	year,
	hires,
	termination,
	hires - termination as net_change,
	ROUND((CAST(hires - termination AS float) / hires) * 100,2) AS net_change_percentage
FROM (
	SELECT 
		YEAR(hire_date) as year, 
		COUNT(*) AS hires, 
		SUM(CASE 
				WHEN termdate IS NOT NULL AND TRY_CONVERT(DATE,LEFT(termdate,10)) <= CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END) AS termination
		FROM HR_data 
		WHERE Age >= 18
		GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY year;
----------------------------------------------------------------------------------------------

-- Average Employment Period for terminated employees

SELECT 
	AVG(DATEDIFF(YEAR,hire_date,TRY_CONVERT(DATE,LEFT(termdate,10)))) as Avg_employment_length
FROM HR_data
WHERE TRY_CONVERT(date, LEFT(termdate,10)) <= GETDATE() AND termdate IS NOT NULL













