/* Main - northwind */

/* Subquery Using EXISTS */
-- Find all my customers with an order in April, 1997
SELECT companyname FROM customers WHERE EXISTS
	(SELECT customerid FROM orders
		WHERE orders.customerid=customers.customerid AND orderdate BETWEEN '1997-04-01' AND '1997-04-30');
-- You could have done above with Join
-- But how would you find customers who didn't have an order in April, 1997
SELECT companyname FROM customers WHERE NOT EXISTS
	(SELECT customerid FROM orders
		WHERE orders.customerid=customers.customerid AND orderdate BETWEEN '1997-04-01' AND '1997-04-30');
-- You can have Joins in Subquery
-- What products didn't have an order in April, 1997
SELECT productname FROM products WHERE NOT EXISTS
	(SELECT productid FROM order_details JOIN orders ON orders.orderid=order_details.orderid
		WHERE order_details.productid=products.productid AND orderdate BETWEEN '1997-04-01' AND '1997-04-30');
-- Find all suppliers with a product that costs more than $200
SELECT companyname FROM suppliers WHERE EXISTS
	(SELECT productid FROM products
		WHERE products.supplierid=suppliers.supplierid AND products.unitprice > 200);
-- Find all suppliers that don't have an order in December 1996
SELECT companyname FROM suppliers WHERE NOT EXISTS
	(SELECT products.productid FROM products 
	 	JOIN order_details ON order_details.productid=products.productid
	 	JOIN orders ON orders.orderid=order_details.orderid
	 		WHERE products.supplierid=suppliers.supplierid AND orders.orderdate > '1996-12-01' AND orders.orderdate < '1996-12-31');

/* Subquery Using ANY and ALL */
-- Find customers with an order detail with more than 50 items in a single product
SELECT companyname FROM customers WHERE customerid=ANY 
	(SELECT customerid FROM orders JOIN order_details 
		ON orders.orderid=order_details.orderid WHERE quantity > 50);
-- Find all suppliers that have had an order with 1 item
SELECT companyname FROM suppliers WHERE supplierid=ANY
	(SELECT products.supplierid FROM products JOIN order_details
		ON products.productid=order_details.productid WHERE quantity=1);
-- Find products which had order amounts that were higher than the average of all the products
SELECT DISTINCT productname FROM products JOIN order_details
	ON products.productid=order_details.productid
		WHERE order_details.unitprice * quantity > ALL
			(SELECT AVG(order_details.unitprice * quantity)
				FROM order_details GROUP BY productid);
-- Find all distinct customers that ordered more in one item than the average order amount per item of all customers
SELECT DISTINCT companyname FROM customers
	JOIN orders ON customers.customerid=orders.customerid
	JOIN order_details ON orders.orderid=order_details.orderid
		WHERE order_details.unitprice * quantity > ALL
			(SELECT AVG(order_details.unitprice * quantity) FROM order_details
				JOIN orders ON orders.orderid=order_details.orderid
					GROUP BY orders.customerid);

/* IN Using Subquery */
-- Find customers that are in the same countries as the suppliers
SELECT companyname FROM customers
	WHERE country IN (SELECT country FROM suppliers);
-- Find all suppliers that are in the same city as a customer
SELECT companyname FROM suppliers
	WHERE city IN (SELECT city FROM customers);
