-- sales amounts by sales staffs in 2018
SELECT
	first_name + ' ' + last_name,
	SUM(quantity * list_price),
	YEAR(order_date)
FROM sales.orders o
INNER JOIN sales.staffs s
	ON s.staff_id = o.staff_id
INNER JOIN sales.order_items i
	ON i.order_id = o.order_id
GROUP BY
	first_name + ' ' + last_name,
	YEAR(order_date)
HAVING
	YEAR(order_date) = 2018;


-- CTEs stands for common table expression
With cte_sales (staff, sales, year)
AS (
	SELECT
	first_name + ' ' + last_name,
	SUM(quantity * list_price),
	YEAR(order_date)
	FROM sales.orders o
	INNER JOIN sales.staffs s
		ON s.staff_id = o.staff_id
	INNER JOIN sales.order_items i
		ON i.order_id = o.order_id
	GROUP BY
		first_name + ' ' + last_name,
		YEAR(order_date)
)

SELECT *
FROM cte_sales
WHERE year = 2018;