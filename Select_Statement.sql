-- ================================================================================================================================================================================
/*
Topic: SELECT STATEMENT
Description: Basic to advanced SELECT queries
*/
-- ================================================================================================================================================================================

-- select all data from the employees table.
select * from employees;

-- select all data from the departments table.
select * from departments;

-- select all data from the salaries table.
select * from salaries;

-- select all data from the attendance table.
select * from attendance;


-- select specific columns from employees table
select emp_name, email, hire_date from 
employees;

-- select dept_name from departments
select dept_name from departments;


-- select male employees from employees table.
select * from employees
where gender = 'Male';

-- select female employees from employees table
select * from employees
where gender = 'Female';

-- Total number of Male employees
select count(emp_name) as total_male_employees 
from employees
where gender = 'Male';

-- Total number of Female employees
select count(emp_name) as total_female_employees 
from employees
where gender = 'Female';


-- employees name starting with A
select * from employees
where emp_name like 'A%';

-- employees that hired in 2023
select * from employees
where year(hire_date) = 2023; 

-- show employees that hired during the financial year 2022-23
select * from employees
where hire_date >= '2022-04-01' and
hire_date <= '2023-03.31';

-- show employees that hired in last 6 month
select * from employees
where hire_date >= date_sub(curdate(),interval 6 month);

-- Order employees by name
select * from employees
order by emp_name;

-- Order employees by empid
select * from employees 
order by emp_id;

-- Get first 10 employees
select * from employees
limit 10;







