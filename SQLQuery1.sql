--Display all the fields in employees table
SELECT *FROM employees;

--Display all the fields in departments table
SELECT *FROM departments;

--Display all the fields in Locations table
SELECT *FROM locations;

--Display the first name, last name and salary of employees
SELECT first_name,last_name,salary FROM employees; 

--Display first name, hire date, salary, phone number and commission of all employees.
SELECT first_name,hire_date,salary,phone_number,commission_pct FROM employees;

--Display first name, last name, salary, and salary increased by 15%.
SELECT first_name,last_name,salary,salary*1.15 FROM employees;

--Display top 10 rows in employees table
SELECT TOP 10 *FROM employees;


--Display top 20 rows from departments table
SELECT top 20 *FROM departments;


--Display top 15 rows from locations tables.
SELECT TOP 15 *FROM locations;

--Display rows after the 10th row
SELECT *FROM employees 
ORDER BY employee_id
OFFSET 10 ROWS;

--Display top 20% of rows from employees table.
SELECT TOP 20 PERCENT *FROM employees
ORDER BY employee_id;


--Display the total number of employees from the employee’s table.
SELECT COUNT(*) AS Total_workers FROM employees;

--Display the lowest salary from employee’s table
SELECT MIN(salary) AS Minimum_Salary FROM employees;

--Display the highest salary from employee’s table
SELECT MAX(salary) AS Highest_Salary FROM employees;

--Display the total salary from employee’s table
SELECT SUM(salary) AS SUM_OF_Salary FROM employees;

--Display the average salary from employee’s table.
SELECT AVG(salary) AS Average_Salary FROM employees;


--Display the first name, last name of employees who earns more than $5000
SELECT first_name, last_name FROM employees 
WHERE salary > 5000;

--Display the first name, last name of employees who earns same or less than $7000
SELECT first_name, last_name FROM employees 
WHERE salary <= 7000;

--Display employees who were hired before 2008-12-24.
SELECT first_name, last_name FROM employees 
WHERE hire_date < '2008-12-24';

--Display employees who were hired after 2008-12-24.
SELECT first_name, last_name FROM employees 
WHERE hire_date > '2008-12-24';



--Display employees who were hired between the period of 2000-12-24 and 2005-11-30.
SELECT *FROM employees
WHERE hire_date BETWEEN '2000-12-24' AND '2005-11-30' 
--Also
SELECT *FROM employees
WHERE hire_date >= '2000-12-24' AND hire_date <= '2005-11-30' 

--Display the salary of employee whose name is Peter Hall
SELECT salary FROM employees
WHERE first_name = 'Peter' AND last_name = 'Hall';

--Write a query to display first name and last name of employees who does not earn commission.
SELECT first_name,last_name FROM employees
WHERE commission_pct IS NULL;

--Issue a query to count the number of employees who does not earn commission.
SELECT COUNT(*) FROM employees
WHERE commission_pct IS NULL;


--Issue a query to count the number of employees who earn commission.
SELECT first_name,last_name FROM employees
WHERE commission_pct IS NOT NULL;

--Issue a query to count the number of employees who earn commission.
SELECT COUNT(*) FROM employees
WHERE commission_pct IS NOT NULL;


--Display first name of employees that begins with P
SELECT first_name FROM employees WHERE first_name LIKE 'P%';

--Display last name of employees that contains U
SELECT * FROM employees WHERE first_name LIKE '%U%';

--Display last name of employees that ends with L
SELECT last_name FROM employees WHERE last_name LIKE '%L';


--SUBQUERRY
--Display all employees that make less than Peter Hall.
SELECT * FROM employees
WHERE salary <(SELECT salary FROM employees WHERE first_name = 'Peter' AND last_name = 'Hall');

--Display all the employees in the same department as Lisa Ozer
SELECT * FROM employees
WHERE department_id =(SELECT department_id FROM employees WHERE first_name = 'Lisa' AND last_name = 'Ozer');

--Display all the employees who were hired before Tayler Fox
SELECT * FROM employees
WHERE hire_date <(SELECT hire_date FROM employees WHERE first_name = 'Tayler' AND last_name = 'Fox');

--Display employees who were hired after Davies.
SELECT * FROM employees
WHERE hire_date >(SELECT hire_date FROM employees WHERE last_name = 'Davies');

--Display all employees who earn more than Abel.
SELECT * FROM employees
WHERE salary >(SELECT salary FROM employees WHERE last_name = 'Abel');

--Display names and salary of the employees in executive department.
SELECT first_name,last_name,salary FROM employees
JOIN departments ON employees.department_id = departments.department_id
WHERE departments.department_name = 'executive';

--Display all the employees in the same department as Martha Sullivan and earn more than TJ Olson.
SELECT first_name, last_name, department_id, salary FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE first_name= 'Martha' AND last_name = 'Sullivan')
AND salary > (SELECT salary from employees WHERE first_name= 'TJ' AND last_name = 'Olson');


SELECT e.first_name, e.last_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id = (
    SELECT e1.department_id
    FROM employees e1
    WHERE e1.first_name = 'Martha' AND e1.last_name = 'Sullivan'
)
AND e.salary > (
    SELECT e2.salary
    FROM employees e2
    WHERE e2.first_name = 'TJ' AND e2.last_name = 'Olson'
);



--Display all departments which exist in the department table but are not present in employee’s table.
SELECT department_name FROM departments
LEFT JOIN employees ON departments.department_id = employees.department_id
WHERE employees.department_id IS NULL;


--Display all departments that exist in department tables and also present in employee’s table.
SELECT department_name
FROM departments
INNER JOIN employees ON departments.department_id = employees.department_id;


--Display all departments from department and employee’s table.
SELECT department_name FROM departments
UNION
SELECT NULL AS department_name FROM employees;

--Display departments in both department and employee’s table without duplicates.
SELECT DISTINCT department_name
FROM departments
INNER JOIN employees ON departments.department_id = employees.department_id;


--Display all employees’ first name, last name and department name.
SELECT first_name,last_name,department_name FROM employees
JOIN departments ON employees.department_id = departments.department_id;

--Display the first name and salary of all the employees in accounting departments. 
SELECT first_name,salary,department_name FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id
WHERE department_name= 'accounting';

SELECT e.first_name,e.salary,d.department_name FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE department_name = 'accounting';


--Display the first name and last name of all employees whose department’s location id are 1700 and 1800.
SELECT first_name,last_name,department_name FROM employees
Left JOIN departments ON employees.department_id = departments.department_id
WHERE location_id IN (1700, 1800);


SELECT e.first_name, e.last_name FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.location_id IN ('1700','1800')



--Display the phone number of all employees in the Marketing department.
SELECT first_name,last_name,phone_number FROM employees
Left JOIN departments ON employees.department_id = departments.department_id
WHERE department_name = 'Marketing';



--Display the department number, last name and Job Id of every employee in Executive department.

SELECT d.department_id, e.last_name, e.job_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Executive';

 
--Display all the employees in the Shipping and Marketing departments who make more than 3100.
SELECT e.first_name, e.last_name, e.salary,d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name IN ('Shipping','Marketing') 
AND e.salary > '3100';


--Display employees first names and the managers they report to.
select * from employees
SELECT e.first_name, m.first_name FROM employees e
JOIN employees m ON e.employee_id = m.employee_id


--GROUP BY	:
--Display the least salary made in each department.

SELECT MIN(salary), department_id FROM employees
GROUP BY department_id;

--Display the highest salary made in each department.
SELECT MAX(salary) AS highest_salary, department_id FROM employees
GROUP BY department_id;
 

--Display the average salary made in each department.
SELECT AVG(salary), department_id FROM employees
GROUP BY department_id;


--Write a query to display each department's name, number of employees, and average salary of employees
SELECT d.department_name, COUNT(e.employee_id),AVG(e.salary)
FROM employees e 
JOIN departments d ON e.department_id = d.department_id
GROUP BY department_name;

--Having Clause:
--Display all departments with their least salary less than $10,000 
SELECT department_id,MIN(salary) FROM employees
GROUP BY department_id
Having MIN(salary) < ('10000');

--Display all departments with their total salary greater than $90,000
SELECT department_id,SUM(salary) FROM employees
GROUP BY department_id
Having SUM(salary) > ('90000');

--Display all departments with their average salary less than $12,000. 
SELECT department_id,AVG(salary) AS Average_payment FROM employees
GROUP BY department_id
Having AVG(salary) < ('12000');



--Table Views
CREATE VIEW Tableview AS (SELECT department_id,AVG(salary) AS Average_payment FROM employees
GROUP BY department_id
Having AVG(salary) < ('12000'));
select* from locations
--Display all employees first name, last name, department name and location. Create a virtual table for this query.

CREATE VIEW ikennaview AS (SELECT e.first_name, e.last_name, d.department_name, l.street_address  FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON  d.location_id = l.location_id);

SELECT * Tableview;

SELECT * Tableview;


--Write a query to display the salary level of each employee such that from those who earns between 2000-4800 are classified as “Low salary earners”, those who earns between 5000-10500 are classified as “Medium salary earners” and others are “High salary earners”.
SELECT first_name, last_name, salary,
CASE
WHEN salary BETWEEN 2000 AND 4000
THEN 'low_salary_earner'
WHEN salary BETWEEN 5000 AND 10500
THEN 'medium_salary_earner'
ELSE 'high_salary_earner'
END AS Salary_level FROM employees;


--Write a query to display if an employee is new, intermediate or old such that those who were hired between 2001- 2003 are classified as “Old employees”, those hired between 2004-2006 are “Intermediate employee” while others are “new employees”.
SELECT first_name, last_name , hire_date,
CASE
WHEN hire_date BETWEEN 2001 AND 2003
THEN 'Old_employee'
WHEN hire_date BETWEEN 2004 AND 2006
THEN 'intermediate_employee'
ELSE 'new_employee'
END AS 'employee_class' FROM employees;

--Date Function
--Display today’s date.
select getdate();

--Extract “day” from hire_date in employees table.
SELECT hire_date, DATENAME(weekday, hire_date) AS particular_day FROM employees;

--Retrieve the unique years from the hire_date in the employees table
SELECT DISTINCT year(hire_date) AS partcular_year FROM employees;

--Extract month name from hire_date in employees table.
SELECT hire_date, DATENAME(month,hire_date) AS particular_month FROM employees;

--Extract weekday name from hire_date in employees table.
SELECT hire_date, DATENAME(weekday,hire_date) AS particular_day FROM employees;

--Display the number of years all the employees have been in the company.
SELECT first_name,last_name,year(hire_date),DATEDIFF(year,hire_date,getdate()) FROM employees;

--Concatenate function:
--Display the full names, salary and phone numbers of all employees.
SELECT CONCAT(first_name,'-',last_name) AS full_name,salary,phone_number FROM employees;

--Upper function:
--Display full names of employees in upper case.
SELECT UPPER(CONCAT(first_name,'-',last_name)) AS full_name FROM employees;

--Lower function:
Display full names of employees in lower case.
SELECT LOWER(CONCAT(first_name,'-',last_name)) AS full_name FROM employees;

--Left function:
--Select first 4 characters from first_name column in employees table
SELECT LEFT(first_name) FROM employees;

--Right function:
--Select last 4 characters from last_name column in employees table
SELECT RIGHT(first_name) FROM employees;

--Len function:
--Select the number of characters from last_name column in employees table.
SELECT LEN(last_name) FROM employees;

--Substring function:
--Selects only 4 characters starting from the 9th value of employees’ phone numbers.
SELECT phone_number, SUBSTRING(phone_number,9,4) AS shortened_num FROM employees;

--Display the first 2 characters of the last_name starting from the 2nd value.
SELECT last_name, SUBSTRING(last_name,2,2) AS shortened_name FROM employees;

--Coalesce Function:
--Replace null values in commission_pct column with 10
SELECT commission_pct,COALESCE(commission_pct,10) AS replaced_null FROM employees;

--Replace Function:
--Replace “-” with “/” in hire_date 
SELECT hire_date,REPLACE(hire_date,'-','/') AS replaced_delimeter FROM employees;

--Replace “.” with “-” in phone_number
SELECT phone_number,REPLACE(phone_number,'.','-') AS Alterd_num FROM employees;



