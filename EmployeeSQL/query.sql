-- Create Table for departments
CREATE TABLE departments (
	dept_no INT PRIMARY KEY
	dept_name VARCHAR	
);

-- Create table for dept employees
CREATE TABLE dept_employees (
	emp_no INTEGERS PRIMARY KEY FK >- Employee_Titles.emp_no
	dep_no VARCHAR FK >- Dept_Manager.dept_no
	from_date VARCHAR
	to_date VARCHAR
);

-- Create table for dept managers
CREATE TABLE dept_manager (
	dept_no INTEGER PK FK >- Departments.dept_no
	emp_no FK >- Employees.emp_no
	from_date VARCHAR
	to_date VARCHAR
);

-- Create table for employees
CREATE TABLE employees (
	emp_no INTEGER PK FK >- Dept_Employees.emp_no
	birth_date VARCHAR
	first_name VARCHAR
	last_name VARCHAR
	gender VARCHAR
	hire_date VARCHAR
);

-- Create table for salaries
CREATE TABLE salaries (
	emp_no INTEGER PK FK >- Dept_Manager.emp_no
	salary INTEGER
	from_date VARCHAR
	to_date VARCHAR
);

-- Create table for employee titles
CREATE TABLE employee_titles ( 
	emp_no INTEGER PK FK >- Salaries.emp_no
	title VARCHAR
	from_date VARCHAR
	to_date VARCHAR
);
