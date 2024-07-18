
-- Calculating Turnover Rate & adding it to the table
ALTER TABLE hr_data
ADD turnover_rate DECIMAL(5,2);


WITH employee_counts AS(
	SELECT count(*) AS start_count
	FROM HR_data
	WHERE hire_date < '2024-07-11'
), 
leaving_counts AS (
	SELECT count(*) AS leave_count
	FROM HR_data
	WHERE termdate IS NOT NULL
), 
employee_end_count AS (
	SELECT count(*) as end_count
	FROM HR_data
	WHERE termdate IS NULL
), turnover_rate_calc AS (
SELECT
	CAST(ROUND((leave_count * 1.0 / ((start_count + end_count)/2.0)) * 100,2) AS decimal(5,2)) AS turnover_rate
FROM 
	employee_counts, leaving_counts, employee_end_count
), 
numbered_rows AS (
	SELECT 
		*, 
		ROW_NUMBER() OVER(ORDER BY(SELECT NULL)) AS row_num
		FROM HR_data
)

UPDATE HR_data
SET turnover_rate = (SELECT turnover_rate FROM turnover_rate_calc)

-------------------------------------------------------------------------------------------------

-- Calculating the age of the employees & adding to the table

-- Altering the table
ALTER TABLE hr_data
ADD Age INT;

-- Adding the age column
UPDATE HR_data
SET Age = DATEDIFF(YY,birthdate,GETDATE()) - 
	CASE
		WHEN DATEADD(YY,DATEDIFF(YY,birthdate,GETDATE()), birthdate) 
		> GETDATE() THEN 1
		ELSE 0
	END;
-------------------------------------------------------------------------------------------------
-- Creating age groups (Currently working employees) 

-- Having an overview on the age scale in the company
SELECT 
	min(age) as min_age, 
	max(age) as max_age 
FROM HR_data
WHERE termdate IS NULL 

-- Having an overview on the age distribution

-- Adding the age_group column
ALTER TABLE hr_data
ADD age_group nvarchar(50);

UPDATE HR_data
SET age_group = 
	CASE 
		WHEN Age >= 18 AND Age <= 25 THEN '18-25'
		WHEN Age >= 26 AND Age <= 35 THEN '26-35'
		WHEN Age >= 36 AND Age <= 45 THEN '36-45'
		WHEN Age >= 46 AND Age <= 55 THEN '46-55'
		ELSE '55+'
	END;

-- Count for each age group (Currently working employees)

SELECT 
	COUNT(*) as count, 
	age_group
FROM hr_data
WHERE termdate IS NULL
GROUP BY age_group
ORDER BY age_group ASC

-------------------------------------------------------------------------------------------------

-- Cleaning Job Titles (Removing Duplicates) 

--- Changing the "Budget/Accounting Analyst" 
Update HR_data
SET jobtitle = 'Budget/Accounting Analyst'
WHERE jobtitle LIKE 'Budget/Accounting Analyst%'

--- Changing the "Computer Systems Analyst"
Update HR_data
SET jobtitle = 'Computer Systems Analyst'
WHERE jobtitle LIKE 'Computer Systems Analyst%'

--- Changing the "Content Developer"
Update HR_data
SET jobtitle = 'Content Developer'
WHERE jobtitle LIKE 'Content Developer%'

--- Changing the "Database Administrator"
Update HR_data
SET jobtitle = 'Database Admin'
WHERE jobtitle LIKE 'Database Administrator%'

--- Changing the "Developer"
Update HR_data
SET jobtitle = 'Developer'
WHERE jobtitle LIKE 'Developer%'

--- Changing the "Engineer"
Update HR_data
SET jobtitle = 'Engineer'
WHERE jobtitle LIKE 'Engineer%'

--- Changing the "Human Resources Analyst"
Update HR_data
SET jobtitle = 'HR Analyst'
WHERE jobtitle LIKE 'Human Resources Analyst%'

--- Changing the "Human Resources Assistant"
Update HR_data
SET jobtitle = 'HR Assistant'
WHERE jobtitle LIKE 'Human Resources Assistant%'

--- Changing the "Media Manager"
Update HR_data
SET jobtitle = 'Media Manager'
WHERE jobtitle LIKE 'Media Manager%'

--- Changing the "Office Assistant"
Update HR_data
SET jobtitle = 'Office Assistant'
WHERE jobtitle LIKE 'Office Assistant%'

--- Changing the "Programmer Analyst"
Update HR_data
SET jobtitle = 'Programmer Analyst'
WHERE jobtitle LIKE 'Programmer Analyst%'

--- Changing the "Programmer"
Update HR_data
SET jobtitle = 'Programmer'
WHERE jobtitle LIKE 'Programmer%'


-- Correcting the "Programmer Analyst" titles
--UPDATE HR_data
--SET jobtitle = 'Programmer Analyst'
--WHERE jobtitle = 'Programmer'
--AND id IN (
--    SELECT TOP 343 id 
--    FROM HR_data 
--    WHERE jobtitle = 'Programmer'
--    ORDER BY id
--);



--- Changing the "Research Assistant"
Update HR_data
SET jobtitle = 'Research Assistant'
WHERE jobtitle LIKE 'Research Assistant%'

--- Changing the "Software Engineer"
Update HR_data
SET jobtitle = 'Software Engineer'
WHERE jobtitle LIKE 'Software Engineer%'

--- Changing the "Software Test Engineer"
Update HR_data
SET jobtitle = 'Software Test Engineer'
WHERE jobtitle LIKE 'Software Test Engineer%'

--- Changing the "Staff Accountant"
Update HR_data
SET jobtitle = 'Staff Accountant'
WHERE jobtitle LIKE 'Staff Accountant%'

--- Changing the "Statistician"
Update HR_data
SET jobtitle = 'Statistician'
WHERE jobtitle LIKE 'Statistician%'

--- Changing the "Support Staff"
Update HR_data
SET jobtitle = 'Support Staff'
WHERE jobtitle LIKE 'Support Staff%'

--- Changing the "Systems Administrator"
Update HR_data
SET jobtitle = 'Systems Administrator'
WHERE jobtitle LIKE 'Systems Administrator%'

--- Changing the "Trainer"
Update HR_data
SET jobtitle = 'Trainer'
WHERE jobtitle LIKE 'Trainer%'

--- Changing the "Web Designer"
Update HR_data
SET jobtitle = 'Web Designer'
WHERE jobtitle LIKE 'Web Designer%'

--- Changing the "Web Developer"
Update HR_data
SET jobtitle = 'Web Developer'
WHERE jobtitle LIKE 'Web Developer%'

--- Changing the "Human Resources Manager"
Update HR_data
SET jobtitle = 'Human Resources Manager'
WHERE jobtitle LIKE 'HR Manager%'

--- Changing the "Service Tech"
Update HR_data
SET jobtitle = 'Service Tech'
WHERE jobtitle LIKE 'Service Tech%'


-- Check what you've done
SELECT jobtitle, COUNT(jobtitle) as count_job_title
FROM HR_data
GROUP BY jobtitle
ORDER BY jobtitle ASC

-- Count of Job titles
SELECT COUNT(DISTINCT jobtitle)
FROM HR_data


