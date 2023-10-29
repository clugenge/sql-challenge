--Creating the tables--
Create Table Titles (
title_id  VARCHAR (255) Primary Key  NOT NULL,
title	VARCHAR (255) NOT NULL);

Create Table employees (
emp_no INTEGER Primary Key  NOT NULL,
emp_title_id VARCHAR NOT NULL,
birth_date Date NOT NULL,
first_name VARCHAR NOT NULL,
last_name VARCHAR NOT NULL,
sex VARCHAR NOT NULL,
hire_date Date  NOT NULL,
FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);
--
Create Table departments(
dept_no VARCHAR  (255)  Primary Key NOT NULL,
dept_name VARCHAR (255) NOT NULL);
--
Create Table department_emp (
emp_no INTEGER NOT NULL,
dept_no	VARCHAR (255) NOT NULL);
--
Create Table department_manager(
dept_no VARCHAR (255) NOT NULL,
emp_no INTEGER Primary Key   NOT NULL);
--
Create Table Salaries (
emp_no Integer Primary Key  Not Null,
salary Integer Not Null,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no));
--
select * from employees

select * from departments

select * from department_emp

select * from department_manager

select * from Salaries

select * from Titles

--- Data Analysis Part 1 --
CREATE VIEW employee_info AS
SELECT employees.emp_no AS "Employee No.",
	employees.last_name AS "Last Name",
	employees.first_name AS "First Name",
	employees.sex AS "Sex",
	salaries.salary AS "Salary"
FROM employees
JOIN salaries ON
employees.emp_no = salaries.emp_no;

SELECT * FROM employee_info;

-- Part 2 --

CREATE VIEW employees_1986 AS
SELECT first_name AS "First Name",
	last_name AS "Last Name",
	hire_date AS "Hire Date 1986"
FROM employees
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31';
ORDER BY hire_date;

SELECT * FROM employees_1986;

-- Part 3 --

CREATE VIEW department_manager AS
SELECT 	department_manager.dept_no AS "Department Number",
	departments.dept_name AS "Department Name",
	employees.emp_no AS "Employee Number",
	employees.last_name AS "Last Name",
	employees.first_name AS "First Name"
FROM employees
JOIN department_manager ON 
employees.emp_no = department_manager.emp_no
JOIN departments ON
department.dept_no = dept_manager.dept_no;

SELECT * FROM department_manager;

-- Part 4 -- 

CREATE VIEW department_employee AS
SELECT department_emp.dept_no AS "Department Number",
	employees.emp_no AS "Employee Number",
	employees.last_name AS "Last Name",
	employees.first_name AS "First Name",
	departments.dept_name AS "Department Name"
FROM employees
JOIN department_emp ON
employees.emp_no = department_emp.emp_no
JOIN departments ON
department_emp.dept_no = departments.dept_no;

SELECT * from department_employee;

-- Part 5 --

CREATE VIEW employee_hercules_b AS
SELECT first_name AS "First Name",
	last_name AS "Last Name",
	sex AS "Sex"
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT * from employee_hercules_b

-- Part 6--

CREATE VIEW employee_sales_department AS
SELECT "Department Name" 
	"Employee Number",
	"Last Name",
	"First Name"
FROM department_employee
WHERE "Department Name" = 'Sales';

SELECT * FROM employee_sales_department;

-- Part 7 -- 
CREATE VIEW employees_sales_development_department AS
SELECT "Department Name",
	"Employee Number",
	"Last Name",
	"First Name"
FROM department_employee
WHERE "Department Name" = 'Sales' OR "Department Name" = 'Development';

SELECT * FROM employees_sales_development_department;

-- Part 8 --

CREATE VIEW employee_frequency_last_names AS
SELECT last_name AS "Last Name",
	COUNT(last_name) AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;

SELECT * FROM employee_frequency_last_names;
