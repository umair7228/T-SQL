-- Basic GROUP BY to count customers in each city
SELECT city, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY city
ORDER BY city;


-- GROUP BY city and state to count customers in each city-state pair
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY city, state
ORDER BY city, state;


-- Using HAVING to filter groups based on aggregate conditions
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY city, state
HAVING COUNT(*) > 10
ORDER BY customer_count DESC;


-- Using HAVING with different aggregate functions
SELECT city, state, COUNT(*) AS customer_count, AVG(list_price) AS avg_price
FROM sales.customers
JOIN sales.orders ON sales.customers.customer_id = sales.orders.customer_id
GROUP BY city, state
HAVING AVG(list_price) > 500
ORDER BY avg_price DESC;


-- Basic use of GROUPING SETS to generate multiple grouping sets
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY GROUPING SETS ((city), (state), (city, state))
ORDER BY city, state;


-- GROUPING SETS with aggregate functions
SELECT city, state, COUNT(*) AS customer_count, SUM(list_price) AS total_price
FROM sales.customers
JOIN sales.orders ON sales.customers.customer_id = sales.orders.customer_id
GROUP BY GROUPING SETS ((city), (state), (city, state))
ORDER BY city, state;


-- Basic use of CUBE to generate grouping sets with all combinations of dimension columns
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY CUBE (city, state)
ORDER BY city, state;

-- CUBE with aggregate functions
SELECT city, state, COUNT(*) AS customer_count, SUM(list_price) AS total_price
FROM sales.customers
JOIN sales.orders ON sales.customers.customer_id = sales.orders.customer_id
GROUP BY CUBE (city, state)
ORDER BY city, state;


-- Basic use of ROLLUP to generate grouping sets with hierarchical relationships
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY ROLLUP (city, state)
ORDER BY city, state;


-- ROLLUP with aggregate functions
SELECT city, state, COUNT(*) AS customer_count, SUM(list_price) AS total_price
FROM sales.customers
JOIN sales.orders ON sales.customers.customer_id = sales.orders.customer_id
GROUP BY ROLLUP (city, state)
ORDER BY city, state;
