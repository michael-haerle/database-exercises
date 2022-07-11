USE employees;
USE sakila;
USE leavitt_1867;
SHOW TABLES;
SELECT DATABASE();
-- DROP TABLE employees_with_departments;
SELECT * FROM employees_with_departments;
SELECT * FROM payment;
DESCRIBE payment;
-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

CREATE TEMPORARY TABLE employees_with_departments (
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
dept_name VARCHAR(50) NOT NULL,
PRIMARY KEY (dept_name));

CREATE TEMPORARY TABLE leavitt_1867.employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees
JOIN dept_emp
USING (emp_no)
JOIN departments
USING (dept_no);


-- a. Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

-- b. Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- c. Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;


-- d. What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE leavitt_1867.employees_with_departments AS
SELECT CONCAT(first_name, ' ', last_name), dept_name
FROM employees
JOIN dept_emp
USING (emp_no)
JOIN departments
USING (dept_no);

-- 2. Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.

SELECT * FROM sakila_payment;
CREATE TEMPORARY TABLE leavitt_1867.sakila_payment AS
SELECT * FROM payment;
ALTER TABLE sakila_payment ADD amount2 INT;
UPDATE sakila_payment
SET amount2 = amount * 100;

-- 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
-- In order to make the comparison easier, you should use the Z-score for salaries. 
-- In terms of salary, what is the best department right now to work for? The worst?

CREATE TEMPORARY TABLE leavitt_1867.best_dept AS
SELECT dept_name, salary, salaries.to_date, dept_emp.to_date
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN salaries
USING (emp_no);


SELECT salary,
    ((SELECT AVG(salary)
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN salaries
USING (emp_no)
WHERE salaries.to_date > NOW()
AND dept_emp.to_date > NOW()
GROUP BY dept_name) - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;

-- Avg salary per department
(SELECT AVG(salary)
FROM departments
JOIN dept_emp
USING (dept_no)
JOIN salaries
USING (emp_no)
WHERE salaries.to_date > NOW()
AND dept_emp.to_date > NOW()
GROUP BY dept_name)
;

-- zscore function
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;