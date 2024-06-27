-- section4: filtering data
-- distinct always takes first value of duplicates records
-- distinct always take NULL values in column as one entity.
SELECT city
FROM sales.customers
ORDER BY city;

SELECT DISTINCT city -- DISTINCT used to drop duplicates
FROM sales.customers
ORDER BY city;

SELECT city, state
FROM sales.customers
ORDER BY city, state;

-- 4.3 Using SELECT DISTINCT with column having NULL
SELECT DISTINCT phone
FROM sales.customers
ORDER BY phone;
-- NOTE: DISTINCT clause keeps only one NULL in the phone column and removes other NULLs.

-- DISTINCT vs. GROUP BY
SELECT city, state 
FROM sales.customers
GROUP BY city, state
ORDER BY city, state;

SELECT DISTINCT city, state
FROM sales.customers;

-- NOTE: Both DISTINCT and GROUP BY clause reduces the number of returned rows in the result set by removing the duplicates.

-- Single line comment
/*
SELECT
    select_list
FROM
    table_name
WHERE
    search_condition;

 NOTE: search_condition can have 
 1. OPERATOR LIKE <,>, <>/!=, IN, LIKE
 2. LOGICAL OPERATORS AND, OR, NOT,
*/

-- Using the WHERE clause with a simple equality operator
SELECT 
	   product_id,
	   product_name,
	   category_id,
	   model_year,
	   list_price
FROM production.products
WHERE category_id = 1
ORDER BY list_price;

-- Using the WHERE clause with the AND operator
SELECT 
	   product_id,
	   product_name,
	   category_id,
	   model_year,
	   list_price
FROM production.products
WHERE category_id = 1 AND model_year = 2018
ORDER BY list_price ;

-- Using WHERE to filter rows using a comparison operator
SELECT 
	   product_id,
	   product_name,
	   category_id,
	   model_year,
	   list_price
FROM production.products
WHERE list_price > 279.99 AND model_year = 2018
ORDER BY list_price ;

-- Using the WHERE clause to filter rows that meet any of two conditions
SELECT 
	   product_id,
	   product_name,
	   category_id,
	   model_year,
	   list_price
FROM production.products
WHERE list_price > 279.99 OR model_year = 2018
ORDER BY list_price ;

-- Using the WHERE clause to filter rows with the value between two values
SELECT 
	   product_id,
	   product_name,
	   category_id,
	   model_year,
	   list_price
FROM production.products
WHERE list_price BETWEEN 1259.99 AND 1999.99
ORDER BY list_price ;

-- Using the WHERE clause to filter rows that have a value in a list of values
SELECT product_id, product_name, model_year, list_price, category_id
FROM production.products
WHERE list_price IN (2799.99, 1799.99, 899.99)
ORDER BY list_price DESC;

-- Finding rows whose values contain a string
SELECT product_id, product_name, model_year, list_price, category_id
FROM production.products
WHERE product_name LIKE '%Townie%'
ORDER BY list_price DESC;

/*
Symbol	Description
%	Represents zero or more characters
_	Represents a single character
[]	Represents any single character within the brackets *
^	Represents any character not in the brackets *
-	Represents any single character within the specified range *
{}	Represents any escaped character **

Link: https://www.w3schools.com/sql/sql_wildcards.asp
*/

-- alias 
SELECT 
	product_id,
	product_name,
	model_year AS year,
	list_price Product_Price,
	category_id 'Product Category'
FROM production.products;

-------------------------------
-- SECTION 05: JOINING DATA
---------------------------------

-- CRAETING SCHEMA
CREATE SCHEMA hr;
go

--creating table
CREATE TABLE hr.candidates(
	id INT IDENTITY(1,1) PRIMARY KEY,
	full_name VARCHAR(255) NOT NULL
);

CREATE TABLE hr.employees(
	id INT IDENTITY(1,1) PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL
);


INSERT INTO hr.candidates(full_name)
VALUES
	('Umair'),
	('Muhammad Noman'),
	('Muhammad Salman'),
	('Arsalan Nawaz');

SELECT *
FROM hr.candidates;

INSERT INTO
	hr.employees(full_name)
VALUES
	('Umair'),
	('Naqeeb Shah'),
	('Muhammad Noman'),
	('Luqman');

SELECT *
FROM hr.employees;

-- INNER join: It will bring the matching values from both tables

-- LEFT TABLE ==> candidates
-- RIGHT TABLE ==> employees

SELECT
	c.id,
	c.full_name,
	e.id,
	e.full_name
FROM hr.candidates c
INNER JOIN hr.employees e
ON c.full_name = e.full_name;

--LEFT join: It will bring the all values from left table and matching values from right table
-- LEFT TABLE ==> candidates
-- RIGHT TABLE ==> employees

SELECT
	c.id,
	c.full_name,
	e.id,
	e.full_name
FROM
	hr.candidates c
	LEFT JOIN hr.employees e
	ON c.full_name = e.full_name;

--RIGHT join: It will bring the all values from right table and matching values from left table
-- LEFT TABLE ==> candidates
-- RIGHT TABLE ==> employees

SELECT
	c.id,
	c.full_name,
	e.id,
	e.full_name
FROM
	hr.candidates c
	RIGHT JOIN hr.employees e
	ON c.full_name = e.full_name;

--OUTER/FULL join: It will bring all rows from both table.
-- LEFT TABLE ==> candidates
-- RIGHT TABLE ==> employees

SELECT
	c.id,
	c.full_name,
	e.id,
	e.full_name
FROM
	hr.candidates c
	FULL JOIN hr.employees e
	ON c.full_name = e.full_name;

--LEFT ANTI join: It will bring the all values from left table that are not matching with right table
-- LEFT TABLE ==> candidates
-- RIGHT TABLE ==> employees

SELECT
	c.id,
	c.full_name,
	e.id,
	e.full_name
FROM
	hr.candidates c
	LEFT JOIN hr.employees e
	ON c.full_name = e.full_name
	WHERE e.id IS NULL;

--RIGHT ANTI join: It will bring the all values from right table that are not matching with left table
-- LEFT TABLE ==> candidates
-- RIGHT TABLE ==> employees

SELECT
	c.id,
	c.full_name,
	e.id,
	e.full_name
FROM
	hr.candidates c
	RIGHT JOIN hr.employees e
	ON c.full_name = e.full_name
	WHERE c.id IS NULL;

-- cross jon
-- a = (1,2,3,)
-- b = (a,b,c)
-- axb = (1,a)(1,b)(1,c).....

--creating a testing database for cross join
CREATE DATABASE testing;
go

USE testing;
go

CREATE SCHEMA cross_join;
go

CREATE TABLE cross_join.Meals(MealName VARCHAR(100));
CREATE TABLE cross_join.Drinks(DrinkName VARCHAR(100));

INSERT INTO cross_join.Drinks
VALUES('Orange Juice'), ('Tea'), ('Cofee');

INSERT INTO cross_join.Meals
VALUES('Omlet'), ('Fried Egg'), ('Sausage');

SELECT *
FROM cross_join.Meals;

SELECT *
FROM cross_join.Drinks;

SELECT *
FROM cross_join.Meals
CROSS JOIN cross_join.Drinks;

-- SELF join: A self join is regular join in which a table is joined to itself.
-- self join is powerfull for comparing values in a column of rows with the same table
USE BikeStore;
go
SELECT *
FROM sales.staffs;

SELECT *
FROM sales.staffs AS T1
INNER JOIN sales.staffs AS T2
ON T2.staff_id = T1.manager_id;