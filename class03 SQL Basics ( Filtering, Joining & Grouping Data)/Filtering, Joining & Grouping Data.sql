USE BikeStores;

-- Section 04: filtering data
-- distinct always takes first value of duplicates records
-- distinct always
SELECT DISTINCT city -- WILL REMOVE DUPLICATES
FROM sales.customers
ORDER BY city;

SELECT DISTINCT city, state -- WILL REMOVE DUPLICATES
FROM sales.customers
ORDER BY city, state;

SELECT DISTINCT phone
FROM sales.customers
ORDER BY phone;

SELECT city, state
FROM sales.customers
GROUP BY city, state
ORDER BY city, state;

SELECT DISTINCT city, state
FROM sales.customers;

-- WHERE clause
/*
SELECT
	select_list
WHERE
	search_condition;

NOTE: search_condition can have
1. Operator like <, >, <>/!=
2. Logical operator AND, OR, NOT
*/

SELECT
	product_id,
	product_name,
	model_year,
	list_price,
	category_id
FROM production.products
WHERE
	model_year = 2018
	AND list_price BETWEEN 900.99 AND 2000.99
ORDER BY list_price DESC;

SELECT
	product_id,
	product_name,
	model_year,
	list_price,
	category_id
FROM production.products
WHERE
	category_id = 1 OR
	model_year = 2018
ORDER BY list_price DESC;

SELECT
	product_id,
	product_name,
	model_year,
	list_price,
	category_id
FROM production.products
WHERE
	list_price IN (1899.00, 1549.99, 919.99)
ORDER BY list_price DESC;

SELECT
	product_id,
	product_name,
	model_year,
	list_price,
	category_id
FROM production.products
WHERE
	product_name LIKE '%Townie%' -- % character must be in begining and ending
ORDER BY list_price DESC;

SELECT
	product_id,
	product_name,
	model_year,
	list_price,
	category_id
FROM production.products
WHERE
	product_name LIKE '__ectra%' -- % character must be in begining and ending
ORDER BY list_price DESC;

-- alias
SELECT
	product_id,
	product_name,
	model_year year,
	list_price AS product_price,
	category_id 'product id'
FROM production.products
ORDER BY list_price DESC;

-- section 05: Joing Tables
CREATE SCHEMA hr;
GO

CREATE TABLE hr.candidates(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
	id INT IDENTITY(1, 1) PRIMARY KEY,
	fullname VARCHAR(100) NOT NULL
);


INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');

INSERT INTO hr.employees(fullname)
VALUES
	('John Doe'),
	('Jane Doe'),
	('Michael Scott'),
	('Jack Sparrow');

SELECT *
FROM
	hr.employees;

-- INNER Join
-- LEFT TABLE ==> candidates
-- RIGHT TABLE ==> employees
SELECT
	c.id,
	c.fullname,
	e.id,
	e.fullname
FROM
	hr.candidates c
	INNER JOIN hr.employees e
	ON e.fullname = c.fullname;

-- LEFT JOIN
SELECT
	c.id,
	c.fullname,
	e.id,
	e.fullname
FROM
	hr.candidates c
	LEFT JOIN hr.employees e
	ON e.fullname = c.fullname;

-- RIGHT JOIN
SELECT
	c.id,
	c.fullname,
	e.id,
	e.fullname
FROM
	hr.candidates c
	RIGHT JOIN hr.employees e
	ON e.fullname = c.fullname;

-- LEFT ANTI JOIN
SELECT
	c.id,
	c.fullname,
	e.id,
	e.fullname
FROM
	hr.candidates c
	LEFT JOIN hr.employees e
	ON e.fullname = c.fullname
	WHERE e.id IS NULL;

CREATE DATABASE testing;
go

USE testing;
go

CREATE SCHEMA cross_join;
go

CREATE TABLE Meals(MealName VARCHAR(100));
CREATE TABLE Drinks(DrinkName VARCHAR(100));

INSERT INTO Drinks
VALUES('Orange Juice'), ('Tea'), ('Cofee');

INSERT INTO Meals
VALUES('Omlet'), ('Fried Egg'), ('Sausage');

SELECT *
FROM Meals;

SELECT *
FROM Drinks;

SELECT *
FROM Meals
CROSS JOIN Drinks;

/*
HOME WORK
1- Wild cards
2- self join
3- joins practice on pandas joins tables
*/