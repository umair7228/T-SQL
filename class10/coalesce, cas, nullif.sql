SELECT
	CASE order_status
		WHEN 1 THEN 'Pending'
		WHEN 2 THEN 'Processing'
		WHEN 3 THEN 'Rejected'
		WHEN 4 THEN 'Completed'
	END AS order_status,
	COUNT (order_id) order_count
FROM sales.orders
GROUP BY order_status;


SELECT 
	SUM(
	CASE
		WHEN order_status = 1
		THEN 1
		ELSE 0
	END ) AS 'Pending',
	SUM(
	CASE
		WHEN order_status = 2
		THEN 1
		ELSE 0
	END ) AS 'Processing',
	SUM(
	CASE
		WHEN order_status = 3
		THEN 1
		ELSE 0
	END ) AS 'Rejected',
	SUM (
	CASE
		WHEN order_status = 4
		THEN 1
		ELSE 0
	END ) AS 'Completed',
	COUNT (*) AS total
FROM sales.orders; 


select
	o.order_id,
	SUM (i.quantity * i.list_price) 'order_value',
	CASE 
		WHEN SUM (i.quantity * i.list_price) >20000
		THEN 'High'
		WHEN SUM (i.quantity * i.list_price) < 20000 and
			 SUM (i.quantity * i.list_price) >=10000
		THEN 'Average Order'
		WHEN SUM (i.quantity * i.list_price) < 10000 and
			 SUM (i.quantity * i.list_price) >= 5000
		THEN 'Fair'
		WHEN SUM (i.quantity * i.list_price) < 5000
		THEN 'Low Value Order'
	END AS 'priorty'
from sales.orders o
inner join sales.order_items i
on o.order_id = i.order_id
where year (o.order_date) = 2018
AND order_status IN (1,2)
group by o.order_id;


----------------SQL Server COALESCE
-- The SQL Server COALESCE expression accepts a number of arguments, evaluates them in sequence, and returns the first non-null argument.
SELECT COALESCE (NULL, NULL, 10, 20, NULL);

SELECT 
    first_name, 
    last_name, 
    COALESCE (phone,'N/A') phone, 
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;


CREATE TABLE salaries (
    staff_id INT PRIMARY KEY,
    hourly_rate decimal,
    weekly_rate decimal,
    monthly_rate decimal,
    CHECK(
        hourly_rate IS NOT NULL OR 
        weekly_rate IS NOT NULL OR 
        monthly_rate IS NOT NULL)
);

INSERT INTO 
    salaries(
        staff_id, 
        hourly_rate, 
        weekly_rate, 
        monthly_rate
    )
VALUES
    (1,20, NULL,NULL),
    (2,30, NULL,NULL),
    (3,NULL, 1000,NULL),
    (4,NULL, NULL,6000),
    (5,NULL, NULL,6500);

SELECT *
FROM salaries;


SELECT
	staff_id,
	hourly_rate,
	weekly_rate,
	COALESCE (hourly_rate * 22 * 8,weekly_rate * 4, monthly_rate) AS monthly_rate
FROM salaries;

/*
SQL Server NULLIF
The NULLIF expression accepts two arguments and returns NULL if two arguments are equal. Otherwise, it returns the first expression.

SYNTAX
NULLIF(expression1, expression2)
*/

SELECT NULLIF (20, 10);

SELECT NULLIF ('Umair', 'Niaz');

-- Using NULLIF expression to translate a blank string to NULL
CREATE TABLE sales.leads
(
    lead_id    INT	PRIMARY KEY IDENTITY, 
    first_name VARCHAR(100) NOT NULL, 
    last_name  VARCHAR(100) NOT NULL, 
    phone      VARCHAR(20), 
    email      VARCHAR(255) NOT NULL
);

INSERT INTO sales.leads
(
    first_name, 
    last_name, 
    phone, 
    email
)
VALUES
(
    'John', 
    'Doe', 
    '(408)-987-2345', 
    'john.doe@example.com'
),
(
    'Jane', 
    'Doe', 
    '', 
    'jane.doe@example.com'
),
(
    'David', 
    'Doe', 
    NULL, 
    'david.doe@example.com'
);

SELECT 
	lead_id,
	first_name,
	last_name,
	phone,
	email
FROM sales.leads
WHERE NULLIF (phone, '') IS NULL;


DECLARE @a int = 10, @b int = 20;

SELECT
CASE
	WHEN @a = @b
	THEN NULL
	ELSE @a
END;
