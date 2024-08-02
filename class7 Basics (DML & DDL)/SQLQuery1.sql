/*
DML, DDL
DML: Data Manipylation Language => Section 11
	1. INSERT
	2. UPDATE
	3. DELETE/TRUNCATE
	4. MERGE
	5. TRANSACTION ( BEGIN, COMMIT, ROLLBACK, GO) not purly in DML

-----------------------------------------------------------------
DDL: Data Definition Language => Section 12
	1. CREATE TABLE

-----------------------------------------------------------------
*/

-- SQL Server INSERT
/*
Syntax:
-------
INSERT INTO table_name (column_list)
VALUES (value_list)
*/

CREATE TABLE sales.promotions (
	promotion_id INT PRIMARY KEY IDENTITY (1, 1),
	promotion_name VARCHAR (255) NOT NULL,
	discount NUMERIC (3, 2) DEFAULT 0,
	start_date DATE NOT NULL,
	expired_date DATE NOT NULL
);

-- table has been created
-----------------------------------------------

-- Simple INSERT
INSERT INTO sales.promotions (
	promotion_name,
    discount,
    start_date,
    expired_date
)
VALUES
    (
        '2018 Summer Promotion',
        0.15,
        '20180601',
        '20180901'
    );
-- values inserted
----------------------------------------

INSERT INTO sales.promotions (
	promotion_name,
    discount,
    start_date,
    expired_date
) OUTPUT inserted.promotion_id
VALUES
    (
        '2018 Fall Promotion',
        0.15,
        '20181001',
        '20181101'
    );

-- INSERT with multiple OUTPUT
INSERT INTO sales.promotions (
	promotion_name,
    discount,
    start_date,
    expired_date
) OUTPUT
	inserted.promotion_id,
	inserted.promotion_name,
	inserted.discount,
	inserted.start_date,
	inserted.expired_date
VALUES
    (
        '2018 Winter Promotion',
        0.2,
        '20181201',
        '20190101'
    );

-------------------------------------------

-- way to add identity column while insertion
SET IDENTITY_INSERT sales.promotions ON;

INSERT INTO sales.promotions (
	promotion_id,
	promotion_name,
    discount,
    start_date,
    expired_date
) OUTPUT
	inserted.promotion_id,
	inserted.promotion_name,
	inserted.discount,
	inserted.start_date,
	inserted.expired_date
VALUES
    (
        4,
        '2019 Spring Promotion',
        0.25,
        '20190201',
        '20190301'
    );

SET IDENTITY_INSERT sales.promotions OFF;

SELECT *
FROM sales.promotions;

-- SQL Server INSERT Multiple Rows
/*
INSERT INTO table_name (column_list)
VALUES
    (value_list_1),
    (value_list_2),
    ...
    (value_list_n);
*/

INSERT INTO sales.promotions (
    promotion_name,
    discount,
    start_date,
    expired_date
)
VALUES
    (
        '2019 Summer Promotion',
        0.15,
        '20190601',
        '20190901'
    ),
    (
        '2019 Fall Promotion',
        0.20,
        '20191001',
        '20191101'
    ),
    (
        '2019 Winter Promotion',
        0.25,
        '20191201',
        '20200101'
    );

-------------------------------------------
INSERT INTO 
	sales.promotions ( 
		promotion_name,
		discount,
		start_date,
		expired_date
	)
OUTPUT inserted.promotion_id
VALUES
	('2020 Summer Promotion',0.25,'20200601','20200901'),
	('2020 Fall Promotion',0.10,'20201001','20201101'),
	('2020 Winter Promotion', 0.25,'20201201','20210101');

SELECT *
FROM sales.promotions;

--------------------------------------------
-- SQL Server INSERT INTO SELECT

CREATE TABLE sales.addresses (
    address_id INT IDENTITY PRIMARY KEY,
    street VARCHAR (255) NOT NULL,
    city VARCHAR (50),
    state VARCHAR (25),
    zip_code VARCHAR (5)
); 
------------------------------------
/*
INSERT  [ TOP ( expression ) [ PERCENT ] ] 
INTO target_table (column_list)
query
*/
-- inserted all rows
-- inserted top 5 rows
-- inserted top 5 percent
INSERT TOP (5) PERCENT
INTO sales.addresses (
	street,
	city,
	state,
	zip_code
) SELECT
	street,
	city,
	state,
	zip_code
FROM sales.customers;


-- To remove all rows from table
TRUNCATE TABLE sales.addresses
SELECT *
FROM sales.addresses;

-----------------------------------
-- insertion with query and where clause
INSERT
INTO sales.addresses (
	street,
	city,
	state,
	zip_code
) SELECT
	street,
	city,
	state,
	zip_code
FROM sales.stores
WHERE city IN ( 'Santa Cruz', 'Baldwin');

SELECT *
FROM sales.addresses

-- SQL Server UPDATE

-- creating tax table
CREATE TABLE sales.taxes (
	tax_id INT PRIMARY KEY IDENTITY (1, 1),
	state VARCHAR (50) NOT NULL UNIQUE,
	state_tax_rate DEC (3, 2),
	avg_local_tax_rate DEC (3, 2),
	combined_rate AS state_tax_rate + avg_local_tax_rate,
	max_local_tax_rate DEC (3, 2),
	updated_at datetime
);

/*
UPDATE table_name
SET c1 = v1, c2 = v2, ... cn = vn
[WHERE condition]
*/

-- update a single column for all rows in the taxes table:
UPDATE sales.taxes
SET updated_at = GETDATE();


-- Update multiple columns example
UPDATE sales.taxes
SET max_local_tax_rate += 0.02,
	avg_local_tax_rate += 0.01
WHERE max_local_tax_rate = 0.01;

SELECT *
FROM sales.taxes
--------------------------------------
-- SQL Server UPDATE JOIN
DROP TABLE IF EXISTS sales.targets;

-- targets table
CREATE TABLE sales.targets
(
    target_id  INT	PRIMARY KEY, 
    percentage DECIMAL(4, 2) 
        NOT NULL DEFAULT 0
);

INSERT INTO 
    sales.targets(target_id, percentage)
VALUES
    (1,0.2),
    (2,0.3),
    (3,0.5),
    (4,0.6),
    (5,0.8);

SELECT *
FROM sales.targets

---------------------------------------
-- commission table
CREATE TABLE sales.commissions
(
    staff_id INT PRIMARY KEY, 
    target_id INT, 
    base_amount DECIMAL(10, 2) 
        NOT NULL DEFAULT 0, 
    commission  DECIMAL(10, 2) 
        NOT NULL DEFAULT 0, 
    FOREIGN KEY(target_id) 
        REFERENCES sales.targets(target_id), 
    FOREIGN KEY(staff_id) 
        REFERENCES sales.staffs(staff_id),
);

INSERT INTO 
    sales.commissions(staff_id, base_amount, target_id)
VALUES
    (1,100000,2),
    (2,120000,1),
    (3,80000,3),
    (4,900000,4),
    (5,950000,5);

SELECT *
FROM sales.targets
SELECT *
FROM sales.commissions

/*
syntax:
UPDATE 
    t1
SET 
    t1.c1 = t2.c2,
    t1.c2 = expression,
    ...   
FROM 
    t1
    [INNER | LEFT] JOIN t2 ON join_predicate
WHERE 
    where_predicate;
*/
-- update commissions based on targets
UPDATE sales.commissions
SET commission = base_amount * t.percentage
FROM
	sales.commissions c
INNER JOIN sales.targets t
	ON c.target_id = t.target_id;


-- supose
INSERT INTO 
    sales.commissions(staff_id, base_amount, target_id)
VALUES
    (6,100000,NULL),
    (7,120000,NULL);

-- update commissions based on targets
-- for new staffs
UPDATE sales.commissions
SET commission = base_amount * COALESCE(t.percentage, 0.1)
FROM
	sales.commissions c
LEFT JOIN sales.targets t
	ON c.target_id = t.target_id;

SELECT *
FROM sales.commissions;


-- SQL Server DELETE
/*
syntax:
DELETE [ TOP ( expression ) [ PERCENT ] ]  
FROM table_name
[WHERE search_condition];
*/
-- crete a history table for products table
SELECT * 
INTO production.product_history
FROM
    production.products;

SELECT *
FROM production.product_history;

DELETE TOP (5) FROM production.product_history;
DELETE TOP (5) PERCENT FROM production.product_history;
DELETE FROM production.product_history;

