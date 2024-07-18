
# HR Analysis Project

## 1. Tools Used:

- SQL
- Power Query (DAX)
- Power BI

## 2. Dataset Used:

HR Data from the year 2000 - 2020 ([[Link](https://github.com/mo7amedashraf98/HR_Dasboard/blob/main/Human%20Resources.csv)])

## 3. Cleaning & Manipulation

### A. Cleaning & Manipulation Using SQL: ([Link](https://github.com/mo7amedashraf98/HR_Dasboard/blob/main/Cleaning%20Queries.sql))

- Loaded the data into an MS SQL Server Database.
- Calculated columns and added them to the table using methods such as CTEs and subqueries for calculations and `ALTER` & `UPDATE` to add the columns to the table.
- Calculated and added some columns that were missing and necessary for the visualization such as Age, Company’s turnover rate, and Age Group.
- Cleaned the job titles columns by eliminating duplicates and changing some job titles to facilitate our work.
- In order to track the employee count change over the years, I used SQL to calculate the count change and then loaded the results from MS SQL Server into a new table in Power BI named `EmployeesCountChange`.

### B. Manipulation Using Power BI (DAX & Power Query):

- To calculate the turnover rate, I had to extract the date from the column `termdate` and store it in a new column named `ParsedTermDate` using DAX.
- Created a new measure to calculate the average employment period for the terminated employees.
- Cleaned and changed some values for the race column.

## 4. Visualization ([Link](https://github.com/mo7amedashraf98/HR_Dasboard/blob/main/HR_Dashboard.jpg))

- Loaded the data from MS SQL Server into a Power BI dashboard.
- Created interactive charts such as donut, line, bar charts, and cards to answer specific questions.
- Some of the questions I answered:
    - What’s the count of employees in each age group?
    - How has the employee count changed over the years?
    - What’s the percentage of employees working remotely vs. working at HQ?
    - What’s the race distribution?
    - What’s the average employment period for terminated employees?
    - What’s the company’s turnover rate?
    - What’s the turnover rate for each department?

