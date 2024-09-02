SELECT    
    first_name,
    last_name,
    email
FROM    
    sales.customers
WHERE 
    SUBSTRING(email, 0, 
        CHARINDEX('@', email, 0)
    ) = 'garry.espinoza';

ALTER TABLE sales.customers
ADD 
    email_local_part AS 
        SUBSTRING(email, 
            0, 
            CHARINDEX('@', email, 0)
        );

create index ix_cust_email_local_part
on sales.customers(email_local_part);

select
	first_name,
	last_name,
	email_local_part
from sales.customers;

-- stored procedure

select
	product_name,
	list_price
from production.products
order by product_name;


create procedure uspProductList
AS
BEGIN
	select
		product_name,
		list_price
	from production.products
	order by product_name
END


EXEC uspProductList;



CREATE PROCEDURE first_procedure_with_parameter(@prd_name VARCHAR(MAX))
AS
BEGIN
	SELECT
		product_name,
		list_price
	FROM production.products
	WHERE product_name = @prd_name
END;

EXEC first_procedure_with_parameter 'Electra Amsterdam Original 3i - 2015/2017';