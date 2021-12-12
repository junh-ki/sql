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


/* INSERT INTO SELECT */


/* Returning Data From Update, Delete and Insert */

