SHOW DATABASES;
USE join_example_db;
SHOW TABLES;
SELECT * FROM roles;
SELECT * FROM users;
-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.

-- Join
SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;
-- Left Join 
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;
-- Right Join
SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

USE employees;
SHOW TABLES;
SELECT * FROM dept_manager;
DESCRIBE dept_manager;
-- PRI emp_no, dept_no
SELECT * FROM departments;
DESCRIBE departments;
-- PRI dept_no
-- UNI dept_name
SELECT * FROM employees;
DESCRIBE employees;
-- PRI emp_no
SELECT * FROM titles;
SELECT * FROM dept_emp;
SELECT * FROM salaries;

SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM departments
JOIN dept_manager
USING (dept_no)
JOIN employees
USING (emp_no)
WHERE to_date > NOW();

-- Find the name of all departments currently managed by women.

SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM departments
JOIN dept_manager
USING (dept_no)
JOIN employees
USING (emp_no)
WHERE to_date > NOW() AND gender = 'F';

-- Find the current titles of employees currently working in the Customer Service department.

SELECT title AS Title, COUNT(title) AS Count
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN employees
USING (emp_no)
JOIN titles
USING (emp_no)
WHERE titles.to_date > NOW() AND dept_name = 'Customer Service'
GROUP BY titles.title;

-- Find the current salary of all current managers.

SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager', salary AS Salary
FROM departments
JOIN dept_manager
USING (dept_no)
JOIN employees
USING (emp_no)
JOIN salaries
USING (emp_no)
WHERE dept_manager.to_date > NOW() AND salaries.to_date > NOW();

-- Find the number of current employees in each department.

SELECT dept_no, dept_name, COUNT(dept_name) AS num_employees
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN employees
USING (emp_no)
WHERE to_date > NOW()
GROUP BY dept_name;

-- Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, AVG(salary) AS average_salary
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN salaries
USING (emp_no)
WHERE salaries.to_date > NOW()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- Who is the highest paid employee in the Marketing department?

SELECT first_name, last_name
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN salaries
USING (emp_no)
JOIN employees
USING (emp_no)
WHERE salaries.to_date > NOW() AND dept_name = 'Marketing'
ORDER BY salary DESC
LIMIT 1
;
-- Determine the average salary for each department. Use all salary information and round your results.

SELECT dept_name, ROUND(AVG(salary)) AS average_salary
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN salaries
USING (emp_no)
WHERE salaries.to_date > NOW()
GROUP BY dept_name;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS 'Employee Name', dept_name AS 'Department Name', 
dm.manager AS 'Department Manager'
FROM departments
JOIN dept_manager
USING (dept_no)
JOIN employees
USING (emp_no)
JOIN dept_emp
USING (emp_no)
JOIN (SELECT 
		CONCAT(employees.first_name, ' ', employees.last_name) AS manager,
		dept_manager.dept_no, 
		dept_manager.to_date
    FROM dept_manager
	LEFT JOIN employees 
		USING (emp_no)
	) as dm
WHERE dm.to_date > NOW() AND dept_emp.to_date > NOW();

-- Bonus Who is the highest paid employee within each department.

SELECT first_name, last_name,
  s.dn AS 'Department Name',
  s.salary AS Salary
FROM (
SELECT departments.dept_name AS dn, MAX(salaries.salary) AS salary
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN salaries
USING (emp_no)
JOIN employees
USING (emp_no)
WHERE salaries.to_date > NOW() AND dept_emp.to_date > NOW()
GROUP BY departments.dept_name) AS s
JOIN salaries ON s.salary = salaries.salary
JOIN employees USING(emp_no)
;

-- Round About Way
SELECT first_name, last_name, dept_name, salary
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN salaries
USING (emp_no)
JOIN employees
USING (emp_no)
WHERE salaries.to_date > NOW() AND dept_name = 'Marketing'
ORDER BY salary DESC
LIMIT 1;

CREATE TABLE highest_paid_emp (
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
dept_name VARCHAR(50) NOT NULL,
salary INT UNSIGNED NOT NULL AUTO_INCREMENT,
PRIMARY KEY (dept_name)
);
INSERT INTO highest_paid_emp (first_name, last_name, dept_name, salary) VALUES
('Akemi', 'Warwick', 'Marketing', 145128);
