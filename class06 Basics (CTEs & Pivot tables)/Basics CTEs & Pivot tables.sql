-- Write a query which return sales amounts by sales staffs in 2018
SELECT
	s.staff_id,
	s.first_name + ' ' + s.last_name AS full_name,
	SUM (i.quantity * list_price * (1 - i.discount)) AS total_sales,
	YEAR (order_date) AS year
FROM sales.orders o
INNER JOIN sales.staffs s
	ON s.staff_id = o.staff_id
INNER JOIN sales.order_items i
	ON i.order_id = o.order_id
GROUP BY
	s.staff_id,
	s.first_name + ' ' + s.last_name,
	YEAR (order_date)
HAVING
	YEAR (order_date) = 2018
ORDER BY staff_id;


-- CTEs Stands for common table expression
/*
SYNTAX
---------
WITH expression_name[(column_name [,...])]
AS
    (CTE_definition)
SQL_statement;

*/
-- Write the same query with CTE
WITH cte_total_sales (staff_id, full_name, total_sales, year)
AS (
	SELECT
		s.staff_id,
		s.first_name + ' ' + s.last_name,
		SUM (i.quantity * i.list_price * (1 - discount)),
		YEAR (order_date)
	FROM
		sales.orders o
	INNER JOIN sales.staffs s
		ON	s.staff_id = o.staff_id
	INNER JOIN sales.order_items i
	    ON i.order_id = o.order_id
	GROUP BY
		s.staff_id,
		s.first_name + ' ' + s.last_name,
		YEAR (order_date)
)

SELECT *
FROM cte_total_sales
WHERE
	year = 2018;


/* 
Write a CTE to return the average number of sales orders in 2018 
for all sales staffs.
*/

SELECT
	staff_id,
	COUNT(*) orders_count
FROM sales.orders
WHERE YEAR(order_date) = 2018
GROUP BY staff_id; --this query selects the total orders of each staff

-------------------------------------------

WITH cte_avg_orders (staff_id, order_count)
AS (
	SELECT
		staff_id,
		COUNT(*) orders_count
	FROM sales.orders
	WHERE YEAR(order_date) = 2018
	GROUP BY staff_id
)

SELECT
	AVG (order_count) AS average_orders
FROM cte_avg_orders; --this cte finds the average of orders



-- multiple SQL Server CTE in a single query example

/*
The following example uses two CTE 
cte_category_counts and cte_category_sales
to return the number of the products and 
sales for each product category. 
The outer query joins two CTEs using the 
category_id column.
*/

WITH cte_category_counts (category_id, category_name, total_products)
AS (
	SELECT
		c.category_id,
		c.category_name,
		COUNT (p.product_name) AS total_products
	FROM production.products p
	INNER JOIN production.categories c
		ON c.category_id = p.category_id
	GROUP BY
		c.category_id,
		c.category_name
),
cte_category_sales (category_id, sales)
AS (
	SELECT
		p.category_id,
		SUM(i.quantity * i.list_price * (1- i.discount))
	FROM sales.order_items i
	INNER JOIN sales.orders o
		ON o.order_id = i.order_id
	INNER JOIN production.products p
		ON p.product_id = i.product_id
	GROUP BY p.category_id
)

SELECT
	cc.category_id,
	cc.category_name,
	cc.total_products,
	cs.sales
FROM cte_category_counts cc
INNER JOIN cte_category_sales cs
	ON cc.category_id = cs.category_id


-- Recurive CTEs
-- ayse CTEs jo bar bar
-- khud ko call kar rhy hoon

/*
WITH expression_name (column_list)
AS
(
    -- Anchor member
    initial_query  
    UNION ALL
    -- Recursive member that references expression_name.
    recursive_query  
)
-- references expression name
SELECT *
FROM   expression_name

Example1: Recursive CTE to returns weekdays
from Monday to Saturday
*/

WITH cte_daysName (n, weekday)
AS (
	SELECT
		0,
		DATENAME(DW, 0)
	UNION ALL
	SELECT
		n + 1,
		DATENAME(DW, n + 1)
	FROM cte_daysName
	WHERE n<6
)

SELECT *
FROM cte_daysName;

WITH cte_org (staff_id, full_name, manager_id)
AS (
	SELECT
		staff_id,
		first_name,
		manager_id
	FROM sales.staffs
	WHERE manager_id IS NULL
	UNION ALL
	SELECT
		e.staff_id,
		e.first_name,
		e.manager_id
	FROM sales.staffs e
	INNER JOIN cte_org o
		ON o.staff_id = e.manager_id
)

SELECT *
FROM cte_org;


-- PIVOT TBALEs
SELECT *
FROM (

	SELECT 
		category_name, 
		product_id,
		model_year
	FROM 
		production.products p
		INNER JOIN production.categories c 
			ON c.category_id = p.category_id
) t
PIVOT (
	COUNT(product_id)
	FOR category_name IN (
		[Children Bicycles],
		[Comfort Bicycles],
		[Cruisers Bicycles],
		[Cyclocross Bicycles],
		[Electric Bikes],
		[Mountain Bikes],
		[Road Bikes])

) AS pivot_table;
