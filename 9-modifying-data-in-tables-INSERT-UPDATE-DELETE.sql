/* Main - northwind */

/* INSERT INTO */
-- Create a new order for customer 'VINET'
SELECT * FROM orders WHERE customerid='VINET';
SELECT MAX(orderid) FROM orders;
INSERT INTO orders 
	(orderid, customerid, employeeid, orderdate, requireddate, shipvia, 
	 freight, shipname, shipaddress, shipcity, shippostalcode, shipcountry)
		VALUES (11078, 'VINET', 4, '2021-12-01', '2021-12-12', 3, 
				42.5, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', '51100', 'France');
-- Insert an order detail for order we just created. Make it an quantity of 20 of Queso Cabrales
-- (you will have to look up id) with a price of $14.
SELECT MAX(orderid) FROM order_details;
SELECT * FROM products WHERE productname='Queso Cabrales';
INSERT INTO order_details
	(orderid, productid, unitprice, quantity, discount)
		VALUES (11078, 11, 14, 20, 0);

/* UPDATE */
-- Update the order we created
-- They need it by 2021-12-02 (10 days earlier), and the shipping cost will increase to $50
UPDATE orders SET requireddate='2021-12-02', freight=50
	WHERE orderid=11078;
-- They also want 40 Queso Cabrales instead of 20 and we are giving a discount of (0.05, 5%).
-- Trick is the WHERE clause to make sure we update the right order details since there is no order detail id field.
UPDATE order_details SET quantity=40, discount=0.05
	WHERE orderid=11078 AND productid=11;

/* DELETE */
-- They cancel the order, so let's first delete the order_detail.
SELECT * FROM order_details WHERE orderid=11078 AND productid=11;
DELETE FROM order_details WHERE orderid=11078 AND productid=11;
-- Delete the order for the customer using the order id.
SELECT * FROM customers
	JOIN orders ON customers.customerid = orders.customerid
	WHERE orderid=11078;
DELETE FROM orders WHERE orderid=11078;

/* SELECT INTO */
-- Let's backup all our suppliers in North America.
-- Then refresh in public schema
SELECT * INTO suppliers_northamerica FROM suppliers WHERE country IN ('USA', 'CANADA');
SELECT * FROM suppliers_northamerica;
-- Backup orders in the year 1997 to a new table orders_1997
SELECT * INTO orders_1997 FROM orders WHERE orderdate BETWEEN '1997-01-01' AND '1997-12-31';
SELECT * FROM orders_1997;

/* INSERT INTO SELECT */
-- Add our suppliers in Brazil and Argentina to suppliers_northamerica
INSERT INTO suppliers_northamerica
	SELECT * FROM suppliers WHERE country IN ('Brazil', 'Argentina');
SELECT * FROM suppliers_northamerica;
-- Add orders from December 2016 to table orders_1997
INSERT INTO orders_1997
	SELECT * FROM orders WHERE orderdate BETWEEN '1996-12-01' AND '1996-12-31';
SELECT * FROM orders_1997;

/* Returning Data From Update, Delete and Insert */
-- Insert a new employee returning the employeeid
SELECT MAX(employeeid) FROM employees;
INSERT INTO employees (firstname, lastname, title, employeeid, reportsto)
	VALUES ('Bob', 'Smith', 'Mr Big', 50, 2)
	RETURNING employeeid;
-- Insert a new order into table (orderid=500) and return the orderid
INSERT INTO orders (customerid, employeeid, requireddate, shippeddate, orderid)
	VALUES ('VINET', 5, '1996-08-01', '1996-08-10', 500)
	RETURNING orderid;
-- Increase the unit price of Chai (productid=1) by 20% and return the new price and productid
UPDATE products SET unitprice=unitprice*1.2
	WHERE productid=1
	RETURNING productid, unitprice AS new_price;
SELECT * FROM products WHERE productid=1;
-- Update order_details for orderid 10248 and productid 11 to double the quantity ordered
-- and return the new quantity
UPDATE order_details SET quantity=quantity*2
	WHERE orderid=10248 AND productid=11
	RETURNING quantity;
SELECT * FROM order_details WHERE orderid=10248 AND productid=11;
-- Delete the employee we just entered (employeeid=50 and return all the rows)
DELETE FROM employees
	WHERE employeeid=50
	RETURNING *;
-- Delete the order you entered (orderid=500) earlier and return all fields
DELETE FROM orders
	WHERE orderid=500
	RETURNING *;
