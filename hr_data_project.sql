CREATE DATABASE class_projects;

-- DATA CLEANING
SET SQL_SAFE_UPDATES = 0;

RENAME TABLE `hr data` to hr_data;

ALTER TABLE hr_data
RENAME COLUMN ï»¿id TO ID;

UPDATE hr_data 
SET birthdate = REPLACE(birthdate, "-", "/");
UPDATE hr_data
SET birthdate = STR_TO_DATE(birthdate, "%m/%d/%Y");
UPDATE hr_data 
SET birthdate = date_sub(birthdate, interval 100 year) where year(birthdate) > 2002;
ALTER TABLE hr_data
MODIFY COLUMN birthdate DATE;

UPDATE hr_data 
SET hire_date = REPLACE(hire_date, "-", "/");
UPDATE hr_data
SET hire_date = STR_TO_DATE(hire_date, "%m/%d/%Y");
ALTER TABLE hr_data
MODIFY COLUMN hire_date DATE;

ALTER TABLE hr_data
ADD COLUMN Age INT;
UPDATE hr_data
SET Age = FLOOR(DATEDIFF(CURRENT_DATE(), birthdate)/365);

ALTER TABLE hr_data
ADD COLUMN Tenure_in_year INT;
UPDATE hr_data
SET Tenure_in_year = CEIL(DATEDIFF(CURRENT_DATE(), hire_date)/365);


-- 1. What is the gender breakdown in the Company? 
SELECT gender, COUNT(gender) AS gender_breakdown FROM hr_data
GROUP BY gender;


-- 2. How many employees work remotely for each department?
SELECT department, COUNT(location) AS remote_workers FROM hr_data
WHERE location = "remote"
GROUP BY department;


-- 3. What is the distribution of employees who work remotely and HQ    ~ location contains remote & HQ workers
SELECT location, COUNT(location) AS distribution FROM hr_data
GROUP BY location;


-- 4. What is the race distribution in the Company? 
SELECT race, COUNT(race) AS race_distribution FROM hr_data
GROUP BY race;


-- 5. What is the distribution of employee across different states? 
SELECT location_state, COUNT(location_state) AS state_distribution FROM hr_data
GROUP BY location_state;


-- 6. What is the number of employees whose employment has been terminated 
-- Note: Termdate is the number of date of contract for the contracted employees not terminated date
SELECT COUNT(DATE(termdate)) AS no_of_terminated_employment FROM hr_data
WHERE DATE(termdate) <= CURRENT_DATE();


-- 7. Who is/are the longest serving employee in the organization
SELECT CONCAT_WS(" ", first_name, last_name) AS full_name, hire_date AS longest_serving_year FROM hr_data
ORDER BY longest_serving_year ASC;


-- 8. Return the terminated employees by their race
SELECT race, COUNT(race) AS count FROM hr_data
WHERE DATE(termdate) <= CURRENT_DATE()
GROUP BY race ORDER BY count DESC;
 
 
-- 9. What is the age distribution in the Company? 
SELECT MIN(Age), MAX(Age) FROM hr_data;
SELECT CASE 
			WHEN Age < 30 THEN "20-29"
            WHEN Age < 40 THEN "30-39" 
            WHEN Age < 50 THEN "40-49"
            ELSE "50-59" END AS Age_group, COUNT(*) AS Age_Distribution FROM hr_data
GROUP BY Age_group ORDER BY Age_group;


-- 10. How have employee hire counts varied over time? 
SELECT MIN(hire_date), MAX(hire_date) FROM hr_data;
SELECT	CASE 
			WHEN YEAR(hire_date) <= 2005 THEN "2000 - 2005"
			WHEN YEAR(hire_date) <= 2010 THEN "2006 - 2010"
			WHEN YEAR(hire_date) <= 2015 THEN "2011 - 2015"
			ELSE "2016 - 2020" END AS hirecount, COUNT(*) AS employee_vary
FROM hr_data GROUP BY hirecount ORDER BY hirecount;


-- 11. What is the tenure distribution for each department? 
-- average tenure distribution in a particular department
SELECT department, ROUND(AVG(Tenure_in_year), 1) AS avg_tenure_year FROM hr_data
GROUP BY 1
ORDER BY 2 DESC;

-- 12. What is the average length of employment in the company? 
SELECT AVG(DATEDIFF(CURRENT_DATE(), hire_date)/365) AS avg_employment_duration FROM hr_data;


-- 13. Which department has the highest turnover rate? 


SELECT * FROM hr_data;