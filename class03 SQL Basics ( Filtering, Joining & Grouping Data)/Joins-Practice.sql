CREATE DATABASE joins;
go

USE joins;
go

CREATE SCHEMA joins;
go

CREATE TABLE joins.left_table(
	dt DATE,
	country_id INT NOT NULL,
	units INT NOT NULL
);

CREATE TABLE joins.right_table(
	id INT NOT NULL,
	country VARCHAR(100) NOT NULL,
);

INSERT INTO joins.left_table(dt, country_id, units)
VALUES
	('1/1/2020', 1, 40),
	('1/2/2020', 1, 25),
	('1/3/2020', 3, 30),
	('1/4/2020', 2, 35);

SELECT *
FROM joins.left_table;

INSERT INTO joins.right_table(id, country)
VALUES
	(3, 'Panama'),
	(4, 'Spain');

SELECT *
FROM joins.right_table;

-- INNER JOIN:
SELECT
	l.dt, l.country_id, l.units,
	r.id, r.country	
FROM joins.left_table l
INNER JOIN joins.right_table r
ON l.country_id = r.id;

-- LEFT JOIN:
SELECT
	l.dt, l.country_id, l.units,
	r.id, r.country
FROM joins.left_table l
LEFT JOIN joins.right_table r
ON l.country_id = r.id;

-- RIGHT JOIN:
SELECT
	l.dt, l.country_id, l.units,
	r.id, r.country
FROM joins.left_table l
RIGHT JOIN joins.right_table r
ON l.country_id = r.id;

-- FULL/OUTER JOIN:
SELECT
	l.dt, l.country_id, l.units,
	r.id, r.country
FROM joins.left_table l
FULL JOIN joins.right_table r
ON l.country_id = r.id;

-- LEFT ANTI JOIN:
SELECT
	l.dt, l.country_id, l.units,
	r.id, r.country
FROM joins.left_table l
LEFT JOIN joins.right_table r
ON l.country_id = r.id
WHERE r.id IS NULL;

-- RIGHT ANTI JOIN:
SELECT
	l.dt, l.country_id, l.units,
	r.id, r.country
FROM joins.left_table l
RIGHT JOIN joins.right_table r
ON l.country_id = r.id
WHERE l.country_id IS NULL;

-- CROSS JOIN: combine each row of one table with each row of another table, and return the Cartesian product of the sets of rows from the tables that are joined.
SELECT
	l.dt, l.country_id, l.units,
	r.id, r.country
FROM joins.left_table l
CROSS JOIN joins.right_table r;

-- SELF JOIN
SELECT *
FROM joins.left_table AS T1
INNER JOIN joins.left_table AS T2
ON T2.country_id = T1.country_id;