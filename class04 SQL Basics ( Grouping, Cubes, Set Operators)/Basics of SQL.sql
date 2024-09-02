USE BikeStores
go

SELECT city, COUNT(*) AS customer_counts
FROM sales.customers
GROUP BY city
ORDER BY city;

SELECT *
FROM sales.customers;

SELECT order_id, YEAR (order_date) AS order_year
FROM sales.orders
GROUP BY order_id;

-- Aggregate functions
-- SUM, AVG, MIN, MAX AND COUNT

SELECT category_id, SUM(list_price)
FROM production.products
GROUP BY category_id;

SELECT
	category_id,
	MAX(list_price) AS max_price,
	MIN(list_price) AS min_price,
	AVG(list_price) AS avg_price
FROM production.products
GROUP BY category_id
HAVING MIN(list_price) > 100;

SELECT *
FROM production.products


-- Creating a new table from existing tables
SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
	SUM (
		quantity * i.list_price * (1 - discount)
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

SELECT *
FROM sales.sales_summary
ORDER BY
	brand,
	category,
	model_year;

-- GROUP BY BRANK
SELECT brand, SUM(sales) AS total_sales
FROM sales.sales_summary
GROUP BY brand
ORDER BY brand;

--- GROUP BY CATEGORY
SELECT category, SUM(sales) AS total_sales
FROM sales.sales_summary
GROUP BY category
ORDER BY category;

--- GROUP BY CATEGORY and BRAND
SELECT brand, category, SUM(sales) AS total_sales
FROM sales.sales_summary
GROUP BY brand, category
ORDER BY brand, category;

-- empty grouping set
SELECT
	SUM (sales) sales
FROM
	sales.sales_summary;

-- grouping set
SELECT brand,
	category,
	SUM (sales) sales
FROM sales.sales_summary
GROUP BY
	GROUPING SETS(
		(brand, category),
		(brand),
		(category),
		())
ORDER BY brand, category;

-- CUBE
SELECT brand,
	category,
	SUM (sales) sales
FROM sales.sales_summary
GROUP BY
	CUBE(brand, category)
ORDER BY brand, category;

-- ROLL UP
SELECT brand,
	category,
	SUM (sales) sales
FROM sales.sales_summary
GROUP BY
	ROLLUP(brand, category)
ORDER BY brand, category;

SELECT brand,
	category,
	SUM (sales) sales
FROM sales.sales_summary
GROUP BY
	ROLLUP(category,brand )
ORDER BY brand, category;

-- SET OPERATORS
-- NO DUPLICATES
SELECT first_name, last_name
FROM sales.customers
UNION
SELECT first_name, last_name
FROM sales.staffs;

-- INSERSECT


