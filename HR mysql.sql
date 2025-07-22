SHOW TABLES;
RENAME TABLE `hr-employee-attrition` TO 
hr_attrition;
-- Explore the data 
SELECT * FROM hr_attrition LIMIT 10;

SELECT COUNT(*) FROM hr_attrition;

-- Check For null/missing data
SELECT 
    SUM(CASE WHEN `Previous Companies Worked` IS NULL
THEN 1 ELSE 0 END) AS Null_PreviousCompaniesWorked,
	SUM(CASE WHEN `Total Working Years` IS NULL 
THEN 1 ELSE 0 END) AS NULL_TotalWorkingYEars
FROM hr_attrition;

DESCRIBE hr_attrition;

-- Changed coulmns types from text to varchar
ALTER TABLE hr_attrition
MODIFY COLUMN Attrition VARCHAR(10),
MODIFY COLUMN `Business Travel` VARCHAR(50),
MODIFY COLUMN Department VARCHAR(50),
MODIFY COLUMN `Education Field` VARCHAR(50),
MODIFY COLUMN Gender VARCHAR(10),
MODIFY COLUMN `Job Role` VARCHAR(50),
MODIFY COLUMN `Marital Status` VARCHAR(20),
MODIFY COLUMN `Over Time` VARCHAR(10);

SHOW COLUMNS FROM hr_attrition;

ALTER TABLE hr_attrition
CHANGE `ï»¿Column1` Age INT;

DESCRIBE hr_attrition; 

USE hr_attrition_project;

SELECT * FROM hr_attrition LIMIT 10;

-- 1.Count the total number of employees in the dataset
SELECT COUNT(*) AS Total_Employees
FROM hr_attrition;

-- 2.Count How many employees have left the company?
SELECT COUNT(*) AS Employees_Left
FROM hr_attrition
WHERE Attrition = 'Yes';

-- 3.Calculate the percentage of the employee who left the company
SELECT
     ROUND(
	      (SUM(CASE WHEN Attrition = 'Yes' THEN 1
ELSE 0 END) * 100.0) /COUNT(*),
	2) AS Attrition_Percentage
FROM hr_attrition;

-- 4.Analyze How Employee attrtion is distributed across depatments
SELECT
	Department,
    COUNT(*) AS Total_Employee,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 
0 END) AS Employee_Left,
    ROUND(
         (SUM(CASE WHEN Attrition = 'Yes' THEN 1
ELSE 0 END) * 100.0) / COUNT(*),
         2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Department
ORDER BY Attrition_Rate DESC;

-- 5.How many male and female empolyees left
SELECT
     Gender,
     COUNT(*) AS Attrition_Count
FROM hr_attrition
WHERE Attrition = 'Yes'
GROUP BY Gender;

-- 6.Identify roles with high attrition
SELECT
     `Job Role`,
     COUNT(*) AS Total,
     SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
     ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
AS Attrition_Rate
FROM hr_attrition
GROUP BY `Job Role`
ORDER BY Attrition_Rate DESC;

-- 7.Check if overtime is linked with attrition
SELECT 
    `Over Time`,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY `Over Time`; 

-- 8.See if job satisfaction level affects attrition
SELECT 
    `Job Satisfaction`,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY `Job Satisfaction`
ORDER BY `Job Satisfaction`;

-- 9.Analyze work-life balance influence
SELECT 
    `Work-Life Balance`,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY `Work-Life Balance`;

-- 10.Avg income comparison for employees who left vs stayed
SELECT 
    Attrition,
    ROUND(AVG(`Monthly Income`), 2) AS Avg_Income
FROM hr_attrition
GROUP BY Attrition;

-- 11.Are long-time employees more likely to stay?
SELECT 
    `Years At Company`,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition
GROUP BY `Years At Company`
ORDER BY `Years At Company`;















