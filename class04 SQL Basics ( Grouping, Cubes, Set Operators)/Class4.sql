-- Group by city and state, count the number of customers in each group
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY city, state
ORDER BY city, state;


-- Group by city and state, count the number of customers in each group
-- Filter the groups to only include those with more than 10 customers
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY city, state
HAVING COUNT(*) > 10
ORDER BY customer_count DESC;


-- Generate multiple grouping sets
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY GROUPING SETS ((city), (state), (city, state))
ORDER BY city, state;


-- Generate grouping sets with all combinations of the dimension columns (city and state)
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY CUBE (city, state)
ORDER BY city, state;


-- Generate grouping sets with an assumption of the hierarchy between input columns (city and state)
SELECT city, state, COUNT(*) AS customer_count
FROM sales.customers
GROUP BY ROLLUP (city, state)
ORDER BY city, state;
