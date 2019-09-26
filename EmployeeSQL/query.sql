-- Drop Tables
DROP TABLE departments, dept_employees, dept_manager, employees, salaries, employee_titles;

-- Review tables
SELECT * FROM dept_employees;


-- Create table for departments
CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

-- Create table for Dept employees
CREATE TABLE "Dept_Employees" (
    "emp_no" INTEGER   NOT NULL,
    "dep_no" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to-date" VARCHAR   NOT NULL
);

-- Create table for Dept Managers
CREATE TABLE "Dept_Manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

-- Create table for Employees
CREATE TABLE "Employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

-- Create table for Salaries
CREATE TABLE "Salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

-- Create table for Employee titles
CREATE TABLE "Employee_Titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

ALTER TABLE "Dept_Employees" ADD CONSTRAINT "fk_Dept_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Employees" ADD CONSTRAINT "fk_Dept_Employees_dep_no" FOREIGN KEY("dep_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Salaries" ("emp_no");

ALTER TABLE "Employee_Titles" ADD CONSTRAINT "fk_Employee_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
CREATE VIEW employee_details AS
Select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM "Employees" e
LEFT JOIN "Salaries" s
ON e.emp_no = s.emp_no;

SELECT * FROM employee_details;

-- 2. List employees who were hired in 1986.
-- Change data type for hire date column from VARCHAR to date.
ALTER TABLE "Employees"
	ALTER COLUMN hire_date TYPE date USING hire_date::date;

-- Extract the hire date year of 1986 from Employee list
CREATE VIEW employees_hired_1986 AS
Select * 
FROM "Employees"
WHERE 
	Extract(YEAR FROM hire_date) = 1986;

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, 
-- first name, and start and end employment dates.

-- Change data type for hire date column from VARCHAR to date.
ALTER TABLE "Dept_Manager"
	ALTER COLUMN from_date TYPE date USING from_date::date,
	ALTER COLUMN to_date TYPE date USING to_date::date;

Select 
	d.dept_no, 
	d.dept_name, 
	dm.emp_no, 
	e.last_name, 
	e.first_name, 
	dm.from_date, 
	dm.to_date
FROM "Departments" d
LEFT JOIN "Dept_Manager" dm
ON d.dept_no = dm.dept_no
LEFT JOIN "Employees" e
ON dm.emp_no = e.emp_no;

-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
CREATE VIEW employee_assignments AS
SELECT 
	e.emp_no, 
	e.last_name,
	e.first_name,
	d.dept_name
FROM "Employees" e
LEFT OUTER JOIN "Dept_Employees" de
ON e.emp_no = de.emp_no
LEFT OUTER JOIN "Departments" d
ON de.dep_no = d.dept_no

-- Drop view
DROP VIEW employee_assignments;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * from employee_assignments
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.
SELECT * from employee_assignments
WHERE dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
SELECT * from employee_assignments
WHERE dept_name = 'Sales' OR dept_name = 'Development';