USE employees;
SHOW TABLES;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM departments;

-- Find all the current employees with the same hire date as employee 101010 using a sub-query.

-- INNER QUERY
-- SELECT * 
-- FROM employees
-- WHERE emp_no = 101010;

SELECT * 
FROM employees
JOIN dept_emp
USING (emp_no)
WHERE to_date > NOW() AND hire_date = (SELECT hire_date 
FROM employees
WHERE emp_no = 101010)
; 
-- 55 records returned

-- Find all the titles ever held by all current employees with the first name Aamod.

SELECT title, a.first_name, a.last_name
FROM 
(SELECT * 
FROM employees
JOIN titles
USING (emp_no)
WHERE first_name = 'Aamod') AS a
WHERE to_date > NOW()
;
-- 168 records returned

-- How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.

SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN
( SELECT emp_no
FROM dept_emp
WHERE to_date > NOW());
-- 59,900 employeesno longer working

-- Find all the current department managers that are female. List their names in a comment in your code.

SELECT g.first_name, g.last_name
FROM 
(SELECT * 
FROM employees
JOIN dept_manager
USING (emp_no)
WHERE gender = 'F') AS g
WHERE to_date > NOW()
;
-- Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT first_name, last_name, salary
FROM employees
JOIN dept_emp
USING (emp_no)
JOIN salaries
USING (emp_no)
WHERE dept_emp.to_date > NOW()  AND salaries.to_date > NOW() AND salary > (SELECT AVG(salary)
FROM salaries)
;
-- 154,543 records returned

-- How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) 
-- What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

-- Curerent salaries within 1 std of current highest salary, 83
SELECT COUNT(*)
FROM salaries
WHERE to_date > NOW() AND salary > 
((SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW()) - 
(SELECT STD(salary)
FROM salaries
WHERE to_date > NOW()))
;

-- 0.03%
SELECT (SELECT COUNT(*)
FROM salaries
WHERE to_date > NOW() AND salary > 
((SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW()) - 
(SELECT STD(salary)
FROM salaries
WHERE to_date > NOW())))/COUNT(salary)
FROM salaries
WHERE to_date > NOW();

-- current highest salary, 158220
SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW();

-- average salary
SELECT AVG(salary)
FROM salaries
WHERE to_date > NOW();

-- all current salaries
SELECT salary
FROM salaries
WHERE to_date > NOW();

-- standard deviation 
SELECT STD(salary)
FROM salaries
WHERE to_date > NOW();

-- BONUS
-- Find all the department names that currently have female managers.

SELECT d.dept_name
FROM 
(SELECT * 
FROM departments
JOIN dept_manager
USING (dept_no)
JOIN employees
USING (emp_no)
WHERE dept_manager.to_date > NOW() AND gender = 'F') as d
;

-- Find the first and last name of the employee with the highest salary.

SELECT first_name, last_name
FROM employees
JOIN dept_emp
USING (emp_no)
JOIN salaries
USING (emp_no)
WHERE salary = (SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW())
;

-- Find the department name that the employee with the highest salary works in.

SELECT first_name, last_name, dept_name
FROM employees
JOIN dept_emp
USING (emp_no)
JOIN salaries
USING (emp_no)
JOIN departments
USING (dept_no)
WHERE salary = (SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW())
;