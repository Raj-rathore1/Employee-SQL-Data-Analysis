-- ================================================================================================================================================================================
/*
Topic: DELETE STATEMENT
*/
-- ================================================================================================================================================================================

set sql_safe_updates=0;

-- delete that employees record from each table who work in data science

select * from departments
where dept_name like "%Data%";  -- here we find out dept_id of data science department


select * from employees
where dept_id= 15; -- here we find out emp_id of employees who work in data science



delete from salaries 
where emp_id = 1001;

alter table salaries auto_increment = 1001;

-- Now we delete record from employees table

delete from employees 
where dept_id= 15;

alter table employees auto_increment = 1001;

-- delete data science department from departments

delete from departments 
where dept_id= 15;

alter table departments auto_increment = 15;







