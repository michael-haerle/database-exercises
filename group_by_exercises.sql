-- In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.

SHOW DATABASES;
USE employees;
SHOW TABLES;
SELECT * FROM titles;
SELECT DISTINCT title FROM titles;
-- 7 records returned

-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name FROM employees WHERE last_name LIKE 'E%' AND last_name LIKE '%E' GROUP BY last_name;

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT last_name, first_name 
FROM employees 
WHERE last_name LIKE 'E%' AND last_name LIKE '%E' 
GROUP BY last_name, first_name;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name 
FROM employees 
WHERE last_name NOT LIKE '%qu%' AND last_name LIKE '%q%'
GROUP BY last_name;
-- Chleq, Lindqvist, Qiwen.

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT COUNT(last_name)
FROM employees 
WHERE last_name NOT LIKE '%qu%' AND last_name LIKE '%q%'
GROUP BY last_name;

-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT COUNT(first_name), gender, first_name
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;

-- Using your query that generates a username for all of the employees, generate a count employees for each unique username. 
-- Are there any duplicate usernames? 
-- BONUS: How many duplicate usernames are there?

SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 4)), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))
AS username,
COUNT(*) AS duplicates
FROM employees
GROUP BY username
HAVING duplicates > 1;
-- Yes there are duplicate usernames. There are 13,251 duplicate usernames.

-- Determine the historic average salary for each employee. 
-- When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

SELECT *
FROM salaries;
SELECT emp_no, AVG(salary)
AS mean_sal
FROM salaries
GROUP BY emp_no;

-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.

SELECT * FROM dept_emp;
SELECT COUNT(emp_no), dept_no
FROM dept_emp
GROUP BY dept_no;

-- Determine how many different salaries each employee has had. This includes both historic and current.

SELECT COUNT(salary), emp_no
FROM salaries
GROUP BY emp_no;

-- Find the maximum salary for each employee.

SELECT MAX(salary), emp_no
FROM salaries
GROUP BY emp_no;

-- Find the minimum salary for each employee.

SELECT MIN(salary), emp_no
FROM salaries
GROUP BY emp_no;

-- Find the standard deviation of salaries for each employee.

SELECT STD(salary), emp_no
FROM salaries
GROUP BY emp_no;

-- Now find the max salary for each employee where that max salary is greater than $150,000.

SELECT emp_no, MAX(salary)
AS max_sal
FROM salaries
GROUP BY emp_no
HAVING max_sal > 150000;

-- Find the average salary for each employee where that average salary is between $80k and $90k.

SELECT emp_no, AVG(salary)
AS mean_sal
FROM salaries
GROUP BY emp_no
HAVING mean_sal > 80000 AND mean_sal < 90000;