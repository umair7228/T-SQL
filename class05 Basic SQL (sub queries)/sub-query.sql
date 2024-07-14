--Sub Queries
-- query inside query

-- write a query which return order_id, order_date and customer_id where city is New York, the query should be sorted by order_date
SELECT o.order_id, o.order_date, c.customer_id
FROM sales.orders o
INNER JOIN sales.customers c
ON o.customer_id = c.customer_id
WHERE c.city = 'New York'
ORDER BY order_date;


-- write the same query using sub-query
SELECT
	order_id,
	order_date,
	customer_id
FROM sales.orders
WHERE customer_id IN (
	SELECT customer_id
	FROM sales.customers
	WHERE city = 'New York')
ORDER BY
	order_date;

-- Using NOT IN to select those customer_idies where city is not New York
SELECT
	order_id,
	order_date,
	customer_id
FROM sales.orders
WHERE customer_id NOT IN (
	SELECT customer_id
	FROM sales.customers
	WHERE city = 'New York')
ORDER BY
	order_date;

-- corelated query
SELECT
	product_name,
	list_price,
	category_id
FROM production.products p1
WHERE list_price IN (
	SELECT
		MAX (list_price)
	FROM production.products p2
	WHERE p1.category_id = p2.category_id
	GROUP BY
		p2.category_id
	)
ORDER BY
	category_id,
	product_name;

-- write a subquery that returns customers who place more then two orders
SELECT *
FROM sales.customers
WHERE customer_id IN (
	SELECT customer_id
	FROM sales.orders
	GROUP BY customer_id
	HAVING COUNT (customer_id) > 2
	)
ORDER BY
	first_name,
	last_name;


-- EXISTS
SELECT *
FROM sales.customers c
WHERE 
	EXISTS(
	SELECT customer_id
	FROM sales.orders o
	WHERE
		o.customer_id = c.c
	GROUP BY customer_id
	HAVING COUNT (customer_id) > 2
	)
ORDER BY
	first_name,
	last_name;