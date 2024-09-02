DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
    id INT IDENTITY(1, 1), 
    a  INT, 
    b  INT, 
    PRIMARY KEY(id)
);


INSERT INTO
    t1(a,b)
VALUES
    (1,1),
    (1,2),
    (1,3),
    (2,1),
    (1,2),
    (1,3),
    (2,1),
    (2,2);

Select * from t1;

-- Using GROUP BY clause to find duplicates in a table
with cte AS (
	select
		a,
		b,
		COUNT(*) occurrences
	from t1
	group by a,b
	having count(*) > 1
	)
DELETE FROM t1
WHERE id IN (
	SELECT
		id
	FROM cte
	WHERE occurrences > 1
);


-- row_number function
with dup_cte AS (
	select
		a,
		b,
		ROW_NUMBER() over (partition by a, b order by a, b) row_num
	from t1 )

select *
from dup_cte
where row_num > 1;




















--To return the entire row for each duplicate row, you join the result of the above query
--with the t1 table using a common table expression (CTE):

WITH cte AS (
    SELECT
        a, 
        b, 
        COUNT(*) occurrences
    FROM t1
    GROUP BY 
        a, 
        b
    HAVING 
        COUNT(*) > 1
)

SELECT 
    t1.id, 
    t1.a, 
    t1.b
FROM t1
    INNER JOIN cte ON 
        cte.a = t1.a AND 
        cte.b = t1.b
ORDER BY 
    t1.a, 
    t1.b;


/* Using ROW_NUMBER() function to find duplicates in a table
The following statement uses the ROW_NUMBER() function to find duplicate rows based on both a and b columns: 


The ROW_NUMBER() function in SQL is a window function that assigns a unique sequential integer to rows within a result set,
based on the order specified in the ORDER BY clause. The numbering starts at 1 and increments by 1 for each row.


*/



WITH cte AS (
    SELECT 
        a, 
        b, 
        ROW_NUMBER() OVER (
            PARTITION BY a,b
            ORDER BY a,b) rownum
    FROM 
        t1
) 
SELECT 
  * 
FROM 
    cte 
WHERE 
    rownum > 1;


 --  Delete using row number 
WITH del_dup AS (
	select
		a,
		b,
		ROW_NUMBER() OVER (PARTITION BY a, b ORDER BY a, b) AS row_num
	from t1
)
DELETE FROM t1
WHERE id IN (
	SELECT id
	FROM del_dup
	WHERE row_num > 1
);


--- Delete using group by query 


	WITH cte AS (
		SELECT
			a, 
			b, 
			COUNT(*) AS occurrences
		FROM t1
		GROUP BY 
			a, 
			b
		HAVING 
			COUNT(*) > 1
	),
	duplicate_rows AS (
		SELECT 
			t1.id
		FROM t1
		INNER JOIN cte ON 
        t1.a = cte.a AND 
        t1.b = cte.b
)
DELETE FROM t1
WHERE id IN (
    SELECT id
    FROM duplicate_rows
);
