-- ================================================================================================================================================================================
/*
																			     ANALYSIS
*/
-- ================================================================================================================================================================================

select * from employees;
select * from departments;
select * from salaries;
select * from attendance;


-- Total Employees
SELECT COUNT(*) AS total_employees
FROM employees;


-- Total number of Male employees
select count(emp_name) as total_male_employees 
from employees
where gender = 'Male';

-- Total number of Female employees
select count(emp_name) as total_female_employees 
from employees
where gender = 'Female';


-- Company Salary Budget Over Time
SELECT YEAR(effective_from) AS salary_year,
       SUM(salary) AS total_salary_budget
FROM salaries
GROUP BY salary_year
ORDER BY salary_year;


-- Average Salary per Department
SELECT d.dept_name,
       ROUND(AVG(s.salary),2) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_name
ORDER BY avg_salary DESC;

-- Average Salary by Gender
SELECT e.gender,
       ROUND(AVG(s.salary),2) AS avg_salary
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY e.gender;


-- Top 3 Highest Paid Employees Per Department
SELECT *
FROM (
    SELECT d.dept_name,
           e.emp_name,
           s.salary,
           ROW_NUMBER() OVER (PARTITION BY d.dept_name ORDER BY s.salary DESC) AS rn
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
    JOIN salaries s ON e.emp_id = s.emp_id
) t
WHERE rn <= 3;



-- Hiring Trend Analysis
SELECT YEAR(hire_date) AS hire_year,
       COUNT(*) AS total_hired
FROM employees
GROUP BY hire_year
ORDER BY hire_year;


-- Monthly Hiring Trend
SELECT YEAR(hire_date) AS hire_year,
       MONTH(hire_date) AS hire_month,
       COUNT(*) AS total_hired
FROM employees
GROUP BY hire_year, hire_month
ORDER BY hire_year, hire_month;


-- Longest Working Employees
SELECT emp_name,
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS experience_years,
       RANK() OVER (ORDER BY hire_date ASC) AS seniority_rank
FROM employees;


-- Attendance Rate Per Month
SELECT DATE_FORMAT(work_date,'%Y-%m') AS month,
       ROUND(SUM(CASE WHEN status='Present' THEN 1 ELSE 0 END)
       *100.0 / COUNT(*),2) AS attendance_rate
FROM attendance
GROUP BY month
ORDER BY month;


-- Department With Highest Average Experience
SELECT d.dept_name,
       ROUND(AVG(TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE())),2) AS avg_experience
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY avg_experience DESC;



-- Get Employee Full Details

DELIMITER //

CREATE PROCEDURE GetEmployeeDetails(IN empId INT)
BEGIN
    SELECT e.emp_id,
           e.emp_name,
           e.gender,
           d.dept_name,
           s.salary,
           s.effective_from
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
    JOIN salaries s ON e.emp_id = s.emp_id
    WHERE e.emp_id = empId
    ORDER BY s.effective_from DESC;
END //

DELIMITER ;


CALL GetEmployeeDetails(102);




-- Latest Salary Per Employee (CTE)

WITH LatestSalary AS (
    SELECT emp_id,
           salary,
           ROW_NUMBER() OVER (PARTITION BY emp_id ORDER BY effective_from DESC) AS rn
    FROM salaries
)
SELECT e.emp_name,
       d.dept_name,
       ls.salary
FROM LatestSalary ls
JOIN employees e ON ls.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE rn = 1;





