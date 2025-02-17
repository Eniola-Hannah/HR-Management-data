# HR Data Analysis with SQL


![hr](https://github.com/user-attachments/assets/6f54b6fe-b715-4818-b23d-041a507308a8)


## Table Of Contents
- [Introduction](#Introduction)
- [Data Overview](#Data-Overview)
- [Project Objective](#Project-Objective)
- [Data Cleaning](#Data-Cleaning)
- [Insights Derivation](#Insights-Derivation)
- [Recommendation](#Recommendation)
- [Repository Contents](#Repository-Contents)
- [Conclusion](#Conclusion)


## Introduction
This project involves analyzing HR management data to uncover insights that support informed decision-making and strategic workforce planning. 
Using SQL, the dataset was queried to answer specific HR-related questions, exploring metrics such as employee demographics, tenure, turnover rates, and more.


## Data-Overview
Dataset Description: The dataset provides comprehensive HR information, including employee demographics, work location, employment status, and tenure details.

Number of Rows & Columns Before Cleaning:
- Rows: 1000
- Columns: 13

Columns Included:
1. EmployeeID: Unique identifier for each employee.
2. first_name: First name of employee.
3. last_name: Last name of employee.
4. birth_date: Employee's date of birth.
5. gender: Gender of the employee.
6. Race: Race of the employee.
7. Department: Department in which the employee works.
8. jobtitle: The position of the employee in the company.
9. Location: Work location (Remote or HQ).
10. hire_date: Date the employee was hired.
11. termdate: the contract date between the employee and the company.
12. location_city: the city the employee resides in
13. location_state: The state of the city the employee resides in.

<img width="941" alt="hr" src="https://github.com/user-attachments/assets/7f34e8c4-065c-407b-9488-54e42c05bdf1" />



## Project-Objective
- Problem Statement
1. What is the gender breakdown in the Company? 
2. How many employees work remotely for each department? 
3. What is the distribution of employees who work remotely and HQ 
4. What is the race distribution in the Company? 
5. What is the distribution of employee across different states? 
6. What is the number of employees whose employment has been terminated 
7. Who is/are the longest serving employee in the organization. 
8. Return the terminated employees by their race 
9. What is the age distribution in the Company? 
10. How have employee hire counts varied over time? 
11. What is the tenure distribution for each department? 
12. What is the average length of employment in the company? 
13. Which department has the highest turnover rate?


## Data-Cleaning
- Renaming the Table name
```sql
RENAME TABLE `hr data` to hr_data;
```
- Renaming Column ID
```sql
ALTER TABLE hr_data
RENAME COLUMN ï»¿id TO ID;
```
- Using the 'REPLACE' string function to standardize the date separator in the date columns
```sql
UPDATE hr_data 
SET birthdate = REPLACE(birthdate, "-", "/");
UPDATE hr_data 
SET hire_date = REPLACE(hire_date, "-", "/");
```
- Converting date fields to standard YYYY-MM-DD format
```sql
UPDATE hr_data
SET birthdate = STR_TO_DATE(birthdate, "%m/%d/%Y");

UPDATE hr_data
SET hire_date = STR_TO_DATE(hire_date, "%m/%d/%Y");
```
- Modifying the date fields datatype
```sql
ALTER TABLE hr_data
MODIFY COLUMN birthdate DATE;

ALTER TABLE hr_data
MODIFY COLUMN hire_date DATE;
```
- Modifying the contents/values of birthdate due to the conversion to standard YYYY-MM-DD format
```sql
UPDATE hr_data 
SET birthdate = date_sub(birthdate, interval 100 year) where year(birthdate) > 2002;
```
- Adding new columns and populating them  ~ Age & Tenure_in_year
```sql
ALTER TABLE hr_data
ADD COLUMN Age INT;
UPDATE hr_data
SET Age = FLOOR(DATEDIFF(CURRENT_DATE(), birthdate)/365);

ALTER TABLE hr_data
ADD COLUMN Tenure_in_year INT;
UPDATE hr_data
SET Tenure_in_year = CEIL(DATEDIFF(CURRENT_DATE(), hire_date)/365);
```


## Insights-Derivation
1. Gender Breakdown: More Males than Females with just a difference of 967, with 605 number of Non-conforming genders.
2. Remote Employees by Department: Engineering has the highest number of remote workers (1616), other departments less than a thousand.
3. Work Location Distribution: 75% work at HQ, while 25% work remotely.
4. Race Distribution: Diverse workforce with no dominant race category.
5. State Distribution: Employees are spread across 7 states, with the majority in Ohio and Pennsylvania.
6. Terminated Employees: 2662 employee's contract have been terminated.
7. Longest Serving Employees: 220 employees with 25 years of service (hired in year 2000).
8. Terminated Employees by Race: White employee has the highest terminations.
9. Age Distribution: Majority of employees are aged between 30-39.
10. Hiring Trends: Hiring peaked in 2000 - 2005.
11. Tenure by Department: Auditing has the highest average tenure (16.0).
12. Average Length of Employment: 14.30 years.


## Recommendation
- Diversity and Inclusion: Continue promoting diversity across all levels.
- Remote Work Policy: Expand remote work opportunities in departments with high remote engagement.
- Career Development: Focus on career advancement for younger employees to maintain engagement.


## Repository-Contents
- HR Data.csv: Contains the raw HR dataset used for the analysis.
- hr_data_project.sql: Contains the SQL queries used to perform the analysis and derive insights.
- HR practice Question.docx: Document outlining the problem statement and objectives for the project


## Conclusion
This analysis provides valuable insights into the company's workforce demographics, tenure patterns, and turnover trends. These insights can be leveraged to enhance HR strategies, improve employee retention, and support strategic decision-making.
