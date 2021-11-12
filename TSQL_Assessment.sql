/*Creating a table-valued function that returns a list of orders including order id, customer id, order status, 
store id and staff id for the given year range*/

CREATE FUNCTION tvf (
    @sdate varchar(30),
	@edate varchar(30)
)
RETURNS TABLE
AS
RETURN
 SELECT 
        order_id,
        customer_id,
        store_id,
		staff_id,
		order_date,
		order_status
    FROM
        sales.orders
    WHERE
        order_date BETWEEN @sdate AND @edate ;

SELECT * FROM tvf(2015, 2018);


/*Creating a trigger that logs all removed records of customers table*/

CREATE TABLE removed_records (
    customer_id int,
	first_name varchar(255),
    last_name varchar(255), 
    phone varchar(12),
	email varchar(20)

);

CREATE TRIGGER deleted_records_trigger
ON sales.customers
FOR DELETE
AS
BEGIN
INSERT INTO removed_records(customer_id, first_name, last_name, phone, email)
select customer_id, first_name, last_name, phone, email from deleted
select * from removed_records
END;

SELECT * FROM sales.customers;
DELETE from sales.customers 
WHERE customer_id = 2;
