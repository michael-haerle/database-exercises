-- 1. Write a query that returns all employees, their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

USE employees;
SHOW TABLES;
SELECT * FROM dept_emp;
SELECT * FROM employees;

SELECT first_name, last_name, dept_no, from_date, to_date,
IF(to_date > NOW(), TRUE, FALSE) AS is_current_employee
FROM dept_emp
JOIN employees
USING (emp_no)
;

-- Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name,
CASE 
WHEN SUBSTR(last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
WHEN SUBSTR(last_name, 1, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
WHEN SUBSTR(last_name, 1, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
END AS 'alpha_group'
FROM dept_emp
JOIN employees
USING (emp_no)
;

-- How many employees (current or previous) were born in each decade?

SELECT count(birth_date),
CASE 
WHEN birth_date BETWEEN '1940-01-01' AND '1949-12-31' THEN '40s'
WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN '50s'
WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN '60s'
WHEN birth_date BETWEEN '1970-01-01' AND '1979-12-31' THEN '70s'
WHEN birth_date BETWEEN '1980-01-01' AND '1989-12-31' THEN '80s'
END AS decade_born_in
FROM employees
GROUP BY decade_born_in
;

-- What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT AVG(salary) AS avg_sal,
CASE 
WHEN dept_name IN ('Development' ,'Research') THEN 'R&D'
WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
ELSE 'Customer Service'
END AS department_groups
FROM dept_emp
JOIN departments USING(dept_no)
JOIN salaries USING(emp_no) WHERE salaries.to_date > NOW()
GROUP BY department_groups;
