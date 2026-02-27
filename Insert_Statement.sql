-- ================================================================================================================================================================================
/*
Topic: INSERT STATEMENT
*/
-- ================================================================================================================================================================================



-- set salary = 0 where salary is null We don't fill null values with mean or middle values because this employees is joined recently and there salary is not updated on data yet.
-- So while making dashboard we show it as pending salaries.

set sql_safe_updates = 0; 

select * from salaries;

update salaries
set salary = 0 
where salary is null;


-- add new data science department in departments table
select * from departments;

insert into departments(dept_name) values
("Data Science");


-- add new employees who recently joined as data scientist in employees table and also set there salary 0 in salaries table
select* from employees;

insert into employees (emp_name, gender, email, hire_date, dept_id)
values 
("Raj Rathore", "Male", "rajrathore3546@gmail.com", "2026-02-10",15);

 select *
from employees
where emp_name like "%Raj%";

select * from salaries;

insert into salaries
values
(1001, 1001,0, "2026-02-10"); 


