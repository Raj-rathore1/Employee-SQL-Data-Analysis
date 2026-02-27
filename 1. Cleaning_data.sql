create database employee_management;
use employee_management;



-- --------------------------------------Check Table Structure--------------------------------------
desc employees;
desc salaries;
desc attendance;
desc departments;


-- --------------------------------------Basic Reviewing Data--------------------------------------
select * from employees;
select * from departments;
select * from salaries;
select * from attendance;



-- ============================================================================ Cleaning Data ============================================================================

-- --------------------------------------(A) Rename Column name--------------------------------------
-- -------- 1. Employees Table
alter table employees rename column `ï»¿emp_id` to emp_id;

-- -------- 2. Departments
alter table employees rename column `ï»¿dept_id` to dept_id;

-- -------- 3. Salaries Table
alter table employees rename column `ï»¿salary_id` to salary_id;

-- -------- 4. Attendance Table
alter table employees rename column `ï»¿attendance_id` to attendance_id;





-- --------------------------------------(C) Remove Duplicates--------------------------------------

-- -------- 1. Employees Table
select *
from (
    select *, ROW_NUMBER() over (partition by emp_id order by emp_id) as rn
    from employees
) t
where rn > 1;

/* -- -------------- Add Identifier column (I have emp_id column as a identifier column but it has duplicates values that's why I create a new one so that i can delete 
duplicates values and after removing duplicates I drop this identifier column so it is for only removing duplicates)
*/

ALTER TABLE employees
ADD COLUMN  id INT AUTO_INCREMENT PRIMARY KEY First;

select * from employees;

DELETE FROM employees
WHERE id IN (
    SELECT id
    FROM (
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY emp_id ORDER BY id) AS rn
        FROM employees
    ) t
    WHERE rn > 1
);

/* -------------------Now I'll remove that identifier column -------------------*/
alter table employees drop column id ;


-- -------- 2. Departments Table

select *
from (
    select *, ROW_NUMBER() over (partition by dept_id order by dept_id) as rn
    from departments
) d
where rn > 1;             -- no duplicates found in departments table


-- -------- 3. Salaries Table
select *
from (
    select *, ROW_NUMBER() over (partition by salary_id order by salary_id) as rn
    from salaries
) s
where rn > 1;             -- no duplicates found in salaries table       


-- -------- 4. Attendance Table
select *
from (
    select *, ROW_NUMBER() over (partition by attendance_id order by attendance_id) as rn
    from attendance
) t
where rn > 1;             -- no duplicates found in attendance table





-- --------------------------------------(D) Handling Null Values--------------------------------------
-- -------- 1. Employees Table
select *
from employees
where emp_name is null
Or email is null
or hire_date is null
or dept_id is null;

-- -------- 2. Departments Table
select *
from departments
where dept_name is null;

-- -------- 3. Salaries Table
select *
from salaries
where emp_id is null
or salary is null
or effective_from is null;

-- -------- 4. Attendance Table
select *
from attendance
where emp_id is null
   or work_date is null
   or status is null;


-- Salaries Table has null values so we find out which employees salary is null
-- ------------ Salaries Table -------------- --
SELECT s.emp_id, e.emp_name, e.dept_id
FROM salaries s
JOIN employees e ON s.emp_id = e.emp_id
WHERE s.salary is null;

update salaries
set salary = 0 
where salary is null;

-- We don't fill null values with mean or middle values because this employees is joined recently and there salary is not updated on data yet.
-- So while making dashboard we show it as pending salaries.






-- --------------------------------------(E)Fix Data Types--------------------------------------
-- -------- 1. Employees Table
select * from employees;
desc employees;
 
set sql_safe_updates= 0;
 
update employees
set hire_date = STR_TO_DATE(hire_date, '%m/%d/%Y');

alter table employees modify hire_date DATE;


-- -------- 2. Departments Table
select * from departments;
desc departments;


-- -------- 3. Salaries Table
select * from salaries;
desc salaries;

update salaries
set effective_from = STR_TO_DATE(effective_from, '%m/%d/%Y');

alter table salaries modify effective_from DATE;


-- -------- 4. Attendance Table
select * from attendance;
desc attendance;

update attendance
set work_date = STR_TO_DATE(work_date, '%m/%d/%Y');

alter table attendance modify work_date DATE;






-- --------------------------------------(F)Fix Formate of Data--------------------------------------
-- -------- 1. Employees Table
select * from employees;

UPDATE employees
SET emp_name = TRIM(emp_name),
gender = TRIM(gender),
email = TRIM(email);

update employees
set email= lower(email);

-- -------- 2. Departments Table
select * from departments;

UPDATE departments
set dept_name = TRIM(dept_name);

-- -------- 4. Attendance Table

select * from attendance;

UPDATE attendance
set status = TRIM(status);





-- --------------------------------------(G)Add Constraints --------------------------------------
-- -------- 1. Employees Table
desc employees;

alter table employees 
add constraint pk_employees primary key (emp_id);

alter table employees
modify emp_id INT auto_increment;

-- -------- 2. Departments Table
desc departments; 

alter table departments 
add constraint pk_departments primary key (dept_id);

alter table departments
modify dept_id INT auto_increment;

-- -------- 3. Salaries Table
desc salaries;

alter table salaries 
add constraint pk_salaries primary key (salary_id);

alter table salaries
modify salary_id INT auto_increment;

-- -------- 4. Attendance Table
desc attendance;

alter table attendance 
add constraint pk_attendance primary key (attendance_id);

alter table attendance
modify attendance_id INT auto_increment;







