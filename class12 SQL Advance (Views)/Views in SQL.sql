CREATE VIEW sales.daily_sales
AS
SELECT
    year(order_date) AS y,
    month(order_date) AS m,
    day(order_date) AS d,
    p.product_id,
    product_name,
    quantity * i.list_price AS sales,
	c.first_name + ' ' + c.last_name as customer_name
FROM
    sales.orders AS o
INNER JOIN sales.order_items AS i
    ON o.order_id = i.order_id
INNER JOIN sales.customers AS c
	ON c.customer_id = o.customer_id
INNER JOIN production.products AS p
    ON p.product_id = i.product_id;


CREATE VIEW sales.staff_sales
AS
SELECT
    s.staff_id,
	first_name + ' ' + last_name as staff_name,
	YEAR(o.order_date) as year,
	SUM(quantity * list_price) as sales
FROM
    sales.orders AS o
INNER JOIN sales.order_items AS i
    ON o.order_id = i.order_id
INNER JOIN sales.staffs AS s
    ON s.staff_id = o.staff_id
GROUP BY
	s.staff_id,
	first_name,
	last_name,
	YEAR(order_date);

select *
from sales.staff_sales
order by staff_id;

select *
from sys.views;

select OBJECT_SCHEMA_NAME (v.object_id) as schema_name,
	name
from sys.views AS v;

select *
from sys.objects
where type = 'V';

select definition
from sys.sql_modules;


-- SQL Server Indexed View
