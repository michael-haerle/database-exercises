USE employees;
SHOW TABLES;
DESCRIBE employees;
-- Numeric, String, Date
DESCRIBE departments;
-- String
DESCRIBE dept_emp;
-- Numeric, String, Date
DESCRIBE dept_manager;
-- Numeric, String, Date
DESCRIBE salaries;
-- Numeric, Date
DESCRIBE titles;
-- Numeric, String, Date

-- Which table(s) do you think contain a numeric type column? 
-- Titles, Salaries, Dept_manager, Dept_emp, and Employees
-- Which table(s) do you think contain a string type column?
-- Titles, Dept_manager, Dept_emp, Departments, and Employees
-- Which table(s) do you think contain a date type column?
-- Titles, Salaries, Dept_manager, Dept_emp, and Employees
-- What is the relationship between the employees and the departments tables? 
-- The employee and department tables were more then likely used to create the dept_emp table.
-- Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;