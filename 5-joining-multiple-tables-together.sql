/* Main - northwind */

/* Grabbing Information from Two Tables */
-- companyname is from customers / orderdate and shipcountry are from orders
SELECT companyname, orderdate, shipcountry FROM orders JOIN customers ON customers.customerid=orders.customerid;
-- Connect employees to orders and pull back first name, last name and order date for all orders
SELECT firstname, lastname, orderdate FROM employees JOIN orders ON employees.employeeid=orders.employeeid;
-- Connect products to suppliers and pull back company name, unit cost and units in stock
SELECT companyname, unitprice, unitsinstock FROM products JOIN suppliers ON products.supplierid=suppliers.supplierid;

/* Grabbing Information from Multiple Tables */
-- Bring back company name, order date, productid, unit price, unit quantity
-- orderdate is from orders / companyname is from customers / unitprice and quantity are from order_details
SELECT companyname, orderdate, unitprice, quantity
	FROM orders 
	JOIN order_details ON orders.orderid=order_details.orderid
	JOIN customers ON customers.customerid=orders.customerid;
-- Connect products to previous query and add product name to fields returned
-- Since order_details and products both have the field, 'unitprice', so the table should be explicitly stated to use the field
SELECT companyname, orderdate, productname, order_details.unitprice, quantity
	FROM orders 
	JOIN order_details ON orders.orderid=order_details.orderid
	JOIN customers ON customers.customerid=orders.customerid
	JOIN products ON order_details.productid=products.productid;
-- Connect categories to previous query and bring back category name
SELECT companyname, orderdate, productname, categoryname, order_details.unitprice, quantity
	FROM orders 
	JOIN order_details ON orders.orderid=order_details.orderid
	JOIN customers ON customers.customerid=orders.customerid
	JOIN products ON order_details.productid=products.productid
	JOIN categories ON categories.categoryid=products.categoryid;
-- Take previous query and add a WHERE clause that select category name of Seafood and amount spent >= 500
SELECT companyname, orderdate, productname, categoryname, order_details.unitprice, quantity
	FROM orders 
	JOIN order_details ON orders.orderid=order_details.orderid
	JOIN customers ON customers.customerid=orders.customerid
	JOIN products ON order_details.productid=products.productid
	JOIN categories ON categories.categoryid=products.categoryid
	WHERE categoryname='Seafood' AND order_details.unitprice * quantity >= 500;

/* Left Joins */
-- Pulls back matching records in the second table and all records in the first table
SELECT companyname, orderid
	FROM customers
	LEFT JOIN orders ON orders.customerid=customers.customerid;
-- Pull back the customers (comapnies) that have no orders
SELECT companyname, orderid
	FROM customers
	LEFT JOIN orders ON orders.customerid=customers.customerid
	WHERE orderid IS NULL;
-- Do a left join between products and order_details
SELECT productname, orderid
	FROM products
	LEFT JOIN order_details ON products.productid=order_details.productid;
-- Use IS NULL to find products without orders
SELECT productname, orderid
	FROM products
	LEFT JOIN order_details ON products.productid=order_details.productid
	WHERE orderid IS NULL;	

/* Right Joins */
-- Pulls back matching records in the first table and all records in the second table
-- Bring back company name and order id using reverse table order from the last lesson
SELECT companyname, orderid
	FROM orders
	RIGHT JOIN customers ON customers.customerid=orders.customerid;
-- Pull back the customers (companies) that have no orders
SELECT companyname, orderid
	FROM orders
	RIGHT JOIN customers ON customers.customerid=orders.customerid
	WHERE orderid IS NULL;
-- Do a right join between customercustomer demo and customers
SELECT companyname, customercustomerdemo.customerid
	FROM customercustomerdemo
	RIGHT JOIN customers ON customercustomerdemo.customerid=customers.customerid;

/* Full Joins */
-- Pulls all records in the first table and all records in the second table
-- Bring back company name, and order id
SELECT companyname, orderid
	FROM customers
	FULL JOIN orders ON customers.customerid=orders.customerid;
-- Do a full join between products and categories
SELECT productname, categoryname
	FROM products
	FULL JOIN categories ON categories.categoryid=products.categoryid;

/* Self Joins */
-- Connect a table back to itself
-- Why would you do this?
---- Hierarchy - like employees who report to other employees
---- Looking for similarities or dissimilarities of the same column - everyone in the same city or with the same birthday
-- Must use aliases to rename the tables so we can differentiate which version of table we are referring to
-- Who are in the same city and order by city
SELECT c1.companyname AS CustomerName1, c2.companyname AS CustomerName2, c1.city 
	FROM customers AS c1
	JOIN customers AS c2 ON c1.city = c2.city
	ORDER BY c1.city;
-- We don't want the customerid in the first table to be equal to that in the second table
-- (I don't want the same customer to connect to itself)
SELECT c1.companyname AS CustomerName1, c2.companyname AS CustomerName2, c1.city 
	FROM customers AS c1
	JOIN customers AS c2 ON c1.city = c2.city
	WHERE c1.customerid <> c2.customerid -- greater than or less than
	ORDER BY c1.city;
-- Find suppliers from the same country and order by country
SELECT s1.companyname AS SupplierName1, s2.companyname AS SupplierName2, s1.country
	FROM suppliers AS s1
	JOIN suppliers AS s2 ON s1.country = s2.country
	WHERE s1.supplierid <> s2.supplierid
	ORDER BY s1.country;

/* USING to Reduce Typing */


/* Even Less Typing with NATURAL */


/* Practice -  */

