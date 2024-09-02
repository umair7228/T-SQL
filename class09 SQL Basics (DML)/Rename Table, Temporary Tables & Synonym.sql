/*
SQL Server Rename Table
SQL server didn't support remane directly

EXEC sp_rename 'old_table_name', 'new_table_name'
*/

CREATE TABLE sales.contr (
    contract_no INT IDENTITY PRIMARY KEY,
    start_date DATE NOT NULL,
    expired_date DATE,
    customer_id INT,
    amount DECIMAL (10, 2)
); 

-- To rename a table
EXEC sp_rename 'sales.contr', 'contracts';

/*
SQL Server Temporary Tables

1- temporary tables
2- global temporary tables
*/

SELECT
	customer_id,
	first_name,
	last_name,
	email
INTO #temporary_table
FROM sales.customers
WHERE state = 'CA';


-- temporary table using CREATE STATEMENT
CREATE TABLE #haro_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);


INSERT INTO #haro_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 2;

SELECT *
FROM #haro_products;

--Global temporary tables
CREATE TABLE ##heller_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

INSERT INTO ##heller_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 3;


/*
SQL Server Synonym
CREATE SYNONYM [ schema_name_1. ] synonym_name 
FOR object;
[ server_name.[ database_name ] . [ schema_name_2 ]. object_name   

*/

CREATE SYNONYM contracts
FOR [BikeStores].[sales].[contracks];

CREATE SYNONYM orders FOR sales.orders;

SELECT * FROM orders;

SELECT name, base_object_name
FROM sys.synonyms

DROP SYNONYM IF EXISTS orders;

-- SQL Server CASE
-- Using simple CASE expression in the select clause
select
	CASE order_status
	WHEN 1 THEN 'Pending'
	WHEN 2 THEN 'Processing'
	WHEN 3 THEN 'Rejected'
	WHEN 4 THEN 'Completed'
	END AS order_status,
	count(order_id) AS order_count
from sales.orders
group by order_status
order by order_status;


-- without groupby using SUM(CASE ..END)
SELECT    
    SUM(CASE
            WHEN order_status = 1
            THEN 1
            ELSE 0
        END) AS 'Pending', 
    SUM(CASE
            WHEN order_status = 2
            THEN 1
            ELSE 0
        END) AS 'Processing', 
    SUM(CASE
            WHEN order_status = 3
            THEN 1
            ELSE 0
        END) AS 'Rejected', 
    SUM(CASE
            WHEN order_status = 4
            THEN 1
            ELSE 0
        END) AS 'Completed'
FROM    
    sales.orders
;


