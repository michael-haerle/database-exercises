USE employees;
SHOW TABLES;
SELECT * FROM employees;
SELECT * FROM departments;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN.

SELECT first_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- 709 rows returned

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
-- Enter a comment with the number of records returned. Does it match number of rows from Q2?

SELECT first_name FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
-- 709 rows returned, yes it matches the rows returned from Q2.

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male.

SELECT first_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') AND gender = 'M';
-- 441 records returned

-- Find all current or previous employees whose last name starts with 'E'. 
-- Enter a comment with the number of employees whose last name starts with E.

SELECT last_name FROM employees WHERE last_name LIKE 'E%';
-- 7330 records returned

-- Find all current or previous employees whose last name starts or ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts or ends with E. 
-- How many employees have a last name that ends with E, but does not start with E?

SELECT last_name FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
-- 30723 records returned
SELECT last_name FROM employees WHERE last_name LIKE '%E';
-- 24292 records returned

-- Find all current or previous employees employees whose last name starts and ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts and ends with E. 
-- How many employees' last names end with E, regardless of whether they start with E?

SELECT last_name FROM employees WHERE last_name LIKE 'E%' AND last_name LIKE '%E';
-- 899 records returned
SELECT last_name FROM employees WHERE last_name LIKE '%E';
-- 24292 records returned

-- Find all current or previous employees hired in the 90s. 
-- Enter a comment with the number of employees returned.

SELECT * FROM employees WHERE hire_date LIKE '199%';
-- 135,214 records returned

-- Find all current or previous employees born on Christmas. 
-- Enter a comment with the number of employees returned.

SELECT * FROM employees WHERE birth_date LIKE '%-12-25';
-- 842 records returned

-- Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with the number of employees returned.

SELECT * FROM employees WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25';
-- 362 records returned

-- Find all current or previous employees with a 'q' in their last name. 
-- Enter a comment with the number of records returned.

SELECT last_name FROM employees WHERE last_name LIKE '%q%';
-- 1873 records returned

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. 
-- How many employees are found?SELECT last_name FROM employees WHERE last_name LIKE '%q%';

SELECT last_name FROM employees WHERE last_name NOT LIKE '%qu%' AND last_name LIKE '%q%';
-- 547 records returned