-- create database for assignment
CREATE DATABASE Assignment;
GO

-- use database
USE Assignment;
GO

-- create schema
CREATE SCHEMA assign;
GO

------------------------------ QUESTION: 1 START ---------------------------------

-- create a table for employees
CREATE TABLE assign.employee (
	id INT IDENTITY (1, 1) PRIMARY KEY ,
	full_name VARCHAR (255) , 
	salary INT ,
	managerId INT ,
);

-- Insert values
INSERT INTO assign.employee (
	full_name,
	salary,
	managerId
) VALUES
	('Umair', 60000, NULL),
	('Salman', 80000, 1),
	('Noman', 75000, 2),
	('Arsalan', 50000, 2),
	('Niaz Ali', 90000, 1),
	('Luqman', 70000, 4),
	('Arbab', 95000, 3);

-- select all values from the table
SELECT *
FROM assign.employee;


/*
QUESTION: 1
	Write a solution to find the employees who earn more than their managers.
*/

SELECT
	e.id,
	e.full_name AS emplyee,
	e.salary,
	e.managerId
FROM assign.employee e
JOIN assign.employee m
ON e.managerId = m.id
WHERE e.salary > m.salary;

------------------------------ QUESTION: 1 END ---------------------------------

------------------------------ QUESTION: 2 START ---------------------------------

-- create a table for employees
CREATE TABLE assign.person (
	id INT IDENTITY (1, 1) PRIMARY KEY ,
	email VARCHAR (255) NOT NULL
	CHECK (email = LOWER(email))
);

-- Insert values
INSERT INTO assign.person (
	email
) VALUES
	('abc@gmail.com'),
	('def@gmail.com'),
	('def@gmail.com'),
	('jkl@gmail.com'),
	('abc@gmail.com')
	;

TRUNCATE TABLE assign.person;

-- QUESTION: Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL. 
SELECT 
	email,
	COUNT(*) AS duplicate_counts
FROM assign.person
GROUP BY
	email
HAVING
	COUNT(*) > 1;

------------------------------ QUESTION: 2 END ---------------------------------

------------------------------ QUESTION: 3 START ---------------------------------
-- QUESTION: Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id. 

-- deleteing duplicates using GROUP BY clause and MAX()
DELETE person 
FROM assign.person
where id not in (
	select MAX(id)
	from assign.person
	group by email
);

select * from assign.person;

-- deleting duplicates using cte and row_number()
WITH duplicate_cte AS (
	SELECT
		id,
		email,
		ROW_NUMBER() OVER (
			PARTITION BY email
			ORDER BY id) AS dup_count
	FROM assign.person
)
DELETE
FROM duplicate_cte
WHERE dup_count > 1;

SELECT * FROM assign.person;

------------------------------ QUESTION: 3 END ---------------------------------

------------------------------ QUESTION: 4 START ---------------------------------

/*QUESTION: Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null. 
Return the result table in any order. */

CREATE TABLE assign.employeeUNI (
    id INT PRIMARY KEY,
    uniqueid INT
);

-- Insert values
INSERT INTO assign.employeeUNI(id, uniqueid) VALUES
    (1, 1001),
    (2, 1002),
    (4, 1003),
    (5, 1004);

SELECT
	e.id,
	e.full_name,
	u.uniqueid
FROM assign.employee e
LEFT JOIN assign.employeeUNI u
	ON e.id = u.id;

select * from assign.employeeUNI;
------------------------------ QUESTION: 4 END ---------------------------------

------------------------------ QUESTION: 5 START ---------------------------------

-- QUESTION: Write a query to find the employee with the minimum salary in each department from a table 
-- Employees with columns EmployeeID, Name, DepartmentID, and Salary.

/*            EXTRA WORK
-- ALTER TABLE assign.employee
ALTER TABLE assign.employee
ADD departmentid VARCHAR(50);


UPDATE assign.employee
SET departmentid = 'Finance'
where employee.id = 7;
*/

------------------- solution
WITH depart_cte AS (
	SELECT
		id,
		full_name,
		departmentid,
		salary,
		ROW_NUMBER() OVER (PARTITION BY departmentid ORDER BY salary) AS num
	FROM assign.employee
)

SELECT
	id,
	full_name,
	departmentid,
	salary
FROM depart_cte
WHERE num = 1;

------------------------------ QUESTION: 5 END ---------------------------------


------------------------------ QUESTION: 6 START ---------------------------------

/* QUESTION: Given a table Orders with columns OrderID, CustomerID, OrderDate, and a table OrderItems with 
columns OrderID, ItemID, Quantity, write a query to find the customer with the highest total order quantity. */
use BikeStore;

SELECT * FROM sales.orders;

SELECT * FROM sales.order_items;

------------ Solution
SELECT TOP 1
	o.customer_id,
	SUM(i.quantity) AS quantity
FROM sales.orders o
inner JOIN sales.order_items i
ON i.order_id = o.order_id
GROUP BY o.customer_id
ORDER BY quantity DESC;

------------------------------ QUESTION: 6 END ---------------------------------

------------------------------ QUESTION: 7 START ---------------------------------

/*QUESTION: Given a table Customers with columns CustomerID, Name, JoinDate, and a table Orders with 
columns OrderID, CustomerID, OrderDate, write a query to find customers who placed their first 
order within the last 30 days. */

SELECT * FROM sales.customers;
SELECT * FROM sales.orders;

SELECT
    c.customer_id,
    (c.first_name + ' ' + c.last_name) AS full_name,
    MIN(o.order_date) AS first_order_date
FROM 
    sales.orders o
INNER JOIN 
    sales.customers c ON c.customer_id = o.customer_id
WHERE
    o.order_date BETWEEN '2018-12-01' AND '2018-12-31'
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    MIN(o.order_date) BETWEEN '2018-12-01' AND '2018-12-31'
ORDER BY 
    first_order_date DESC;


------------------------------ QUESTION: 7 END ---------------------------------


------------------------------ QUESTION: 8 START ---------------------------------

/*Write a solution to find the second highest salary from the Employee table. If there is no 
second highest salary, return null (return None in Pandas). */

USE Assignment;

select * from assign.employee;

SELECT 
    id,
    salary
FROM 
    assign.employee
WHERE 
    salary = (
        SELECT 
            MAX(salary) 
        FROM 
            assign.employee 
        WHERE 
            salary < (SELECT MAX(salary) FROM assign.employee)
    );

------------------------------ QUESTION: 8 END ---------------------------------


------------------------------ QUESTION: 9 START ---------------------------------
-- Write a solution to find employees who have the highest salary in each of the departments.

-- creating table for department
CREATE TABLE assign.department (
	id INT IDENTITY(1, 1) PRIMARY KEY,
	depart_name VARCHAR(50) NOT NULL
);


INSERT INTO assign.department (depart_name)
VALUES
    ('IT'),
    ('Finance'),
    ('Sales'),
    ('Sales'),
    ('Marketing'),
	('Finance'),
    ('IT');


-- creating table for employees
CREATE TABLE assign.depart_employee (
	id INT IDENTITY(1, 1) PRIMARY KEY,
	employee_name VARCHAR(50),
	salary INT,
	department_id INT
	FOREIGN KEY (department_id) REFERENCES assign.department(id)
	ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO assign.depart_employee (employee_name, salary, department_id) VALUES
('Umair', 60000, 1), 
('Nawaz', 55000, 2),  
('Noman', 70000, 3),
('Salman', 65000, 4), 
('Arsalan', 58000, 2),
('Niaz Ali', 72000, 1), 
('Luqman', 62000, 5); 

-- Write a solution to find employees who have the highest salary in each of the departments.

SELECT
	e.employee_name,
	e.salary,
	d.depart_name
FROM assign.depart_employee e
JOIN assign.department d
ON e.id = d.id
WHERE e.salary = (
	SELECT
		MAX(salary)
	FROM assign.depart_employee
	WHERE department_id = e.department_id
)


------------------------------ QUESTION: 9 END ---------------------------------

------------------------------ QUESTION: 10 START ---------------------------------

/*Write a solution to report the customer ids from the Customer table that bought all the 
products in the Product table. 
Return the result table in any order.*/

-- Creating Product table
CREATE TABLE assign.product (
    product_key INT PRIMARY KEY
);

-- Inserting sample data into Product table
INSERT INTO assign.product(product_key) VALUES
(1),
(2),
(3),
(4);

-- Creating Customer table
CREATE TABLE assign.customer (
    customer_id INT NOT NULL,
    product_key INT,
    FOREIGN KEY (product_key) REFERENCES assign.product(product_key)
	ON DELETE CASCADE ON UPDATE CASCADE
);

-- Inserting sample data into Customer table
INSERT INTO assign.customer(customer_id, product_key) VALUES
(101, 1),
(101, 2),
(101, 3),
(101, 4),
(102, 1),
(102, 2),
(103, 1),
(103, 2),
(103, 3),
(103, 4);

-- Write a solution to report the customer ids from the Customer table that bought all the products in the Product table. 

SELECT 
	c.customer_id
FROM assign.customer c
JOIN assign.product p
ON c.product_key = p.product_key
GROUP BY c.customer_id
HAVING 
	COUNT(DISTINCT p.product_key) = (
		SELECT COUNT(*)
		FROM assign.product
	);
------------------------------ QUESTION: 10 END ---------------------------------