-- Group By clause

SELECT city, count(city) AS Count_of_City
FROM sales.customers
GROUP BY city
ORDER BY city;

-- 2nd Query
SELECT order_id, Year (order_date) as order_year
FROM sales.orders
GROUP BY order_id,Year (order_date);


-- Aggregate Functions
-- SUM, AVG,MIN,MAX AND COUNT 

SELECT category_id, SUM (list_price)
FROM production.products
GROUP BY category_id;

SELECT category_id, MIN (list_price)
FROM production.products
GROUP BY category_id;

SELECT category_id,
	MIN (list_price) as min_price, 
	MAX (list_price) as max_price, 
	AVG (list_price) as avg_price
FROM production.products	
GROUP BY category_id;

-- Having clause
SELECT category_id,
	MIN (list_price) as min_price, 
	MAX (list_price) as max_price, 
	AVG (list_price) as avg_price
FROM production.products
GROUP BY category_id
HAVING MIN(list_price) > 100 AND MAX(list_price) > 1000;

 --- CREATING A NEW TABLE from existing tables
-- brand, category, model_year and sales

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;

SELECT
	*
FROM
	sales.sales_summary
ORDER BY
	brand,
	category,
	model_year;

	--  Empty grouping set
SELECT
    SUM (sales) sales
FROM
    sales.sales_summary;

-- GROUPING SET
SELECT
	category,
	brand,
	SUM (sales) sales
FROM sales.sales_summary
GROUP BY
	GROUPING SETS (
	(brand, category),
	(brand),
	(category),
	()
	)
ORDER BY
	brand,
	category;

-- SQL Server CUBE
SELECT
	brand,
	category,
	SUM (sales) sales
FROM sales.sales_summary
GROUP BY
	CUBE (brand, category);

-- SQL Server ROLLUP
SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    ROLLUP(brand, category);

-- SAME COLUMNS 
--  NO DUPLICATES 
-- SET OPERATORS
-- Union
SELECT first_name, last_name
FROM sales.customers
UNION
SELECT first_name, last_name
FROM sales.staffs;

-- UNION ALL 
SELECT first_name, last_name
FROM sales.customers
UNION ALL
SELECT first_name, last_name
FROM sales.staffs
ORDER BY first_name, last_name;

-- INTERSECT 

SELECT  last_name
FROM sales.customers
INTERSECT
SELECT  last_name
FROM sales.staffs;

-- EXCEPT
SELECT
    city
FROM
    sales.customers
EXCEPT
SELECT
    city
FROM
    sales.stores
ORDER BY
    city;