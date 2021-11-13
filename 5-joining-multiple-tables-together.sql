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
-- ON customers.customerid=orders.customerid <- lots of typing
-- Shortcut: USING(customerid)
SELECT * FROM orders JOIN order_details USING (orderid);
-- Add products to the previous join of orders and order_details
SELECT * FROM orders 
	JOIN order_details USING (orderid) 
	JOIN products USING (productid);

/* Even Less Typing with NATURAL */
-- NATURAL is a shorthand for USING with a list of all columns that are the same in both tables
SELECT * FROM orders NATURAL JOIN order_details;
-- Add customers to the previous query using NATURAL JOIN
-- Warning: you must order the joins correctly. The NATURAL must connect the previous table to the next table
-- or it will do a cross join connecting every row to every other row
SELECT * FROM customers
	NATURAL JOIN orders
	NATURAL JOIN order_details; -- customer links to orders (customerid), orders links to order_details (orderid)
-- Warning: It will match all fields that have the same name
-- Won't work joining products to order_details because of the second field unitprice that is in both tables
-- Must use USING or a JOIN ON syntax
SELECT COUNT(*) FROM products
	NATURAL JOIN order_details; -- 1493
SELECT COUNT(*) FROM products
	JOIN order_details USING (productid); -- 2155

/* Practice - AdventureWorks */

-- Join (with inner join) together person, personphone, businessentity and phonenumber type in the persons schema.
-- Return first name, middle name, last name, phone number and the name of the phone number type (home, office, etc.)  
-- Order by business entity id descending.
SELECT firstname, middlename, lastname, phonenumber, name from person.person
	JOIN person.personphone ON person.businessentityid=personphone.businessentityid
	JOIN person.phonenumbertype ON personphone.phonenumbertypeid=personphone.phonenumbertypeid
	ORDER BY person.businessentityid DESC;
-- USING
SELECT firstname, middlename, lastname, phonenumber, name from person.person
	JOIN person.personphone USING (businessentityid)
	JOIN person.phonenumbertype USING (phonenumbertypeid)
	ORDER BY person.businessentityid DESC;

-- Join (Inner) productmodel, productmodelproductiondescriptionculture, productdescription and culture from the production schema.
-- Return the productmodel name, culture name, and productdescription description ordered by the product model name.
SELECT productmodel.name AS modelname, culture.name AS culturename, description from production.productmodel
	JOIN production.productmodelproductdescriptionculture ON production.productmodel.productmodelid=production.productmodelproductdescriptionculture.productmodelid
	JOIN production.culture ON production.productmodelproductdescriptionculture.cultureid=production.culture.cultureid
	JOIN production.productdescription ON production.productmodelproductdescriptionculture.productdescriptionid=production.productdescription.productdescriptionid
	ORDER BY production.productmodel.name;
-- USING
SELECT productmodel.name AS modelname, culture.name AS culturename, description from production.productmodel
	JOIN production.productmodelproductdescriptionculture USING (productmodelid)
	JOIN production.culture USING (cultureid)
	JOIN production.productdescription USING (productdescriptionid)
	ORDER BY production.productmodel.name;

-- Add a join to previous example to production.product and return the product name field in addition to other information.
SELECT product.name AS productname, productmodel.name AS modelname, culture.name AS culturename, description from production.productmodel
	JOIN production.productmodelproductdescriptionculture ON production.productmodel.productmodelid=production.productmodelproductdescriptionculture.productmodelid
	JOIN production.culture ON production.productmodelproductdescriptionculture.cultureid=production.culture.cultureid
	JOIN production.productdescription ON production.productmodelproductdescriptionculture.productdescriptionid=production.productdescription.productdescriptionid
	JOIN production.product ON production.productmodel.productmodelid=production.product.productmodelid
	ORDER BY production.productmodel.name;
-- USING
SELECT productmodel.name AS modelname, culture.name AS culturename, description from production.productmodel
	JOIN production.productmodelproductdescriptionculture USING (productmodelid)
	JOIN production.culture USING (cultureid)
	JOIN production.productdescription USING (productdescriptionid)
	JOIN production.product USING (productmodelid)
	ORDER BY production.productmodel.name;

-- Join product and productreview in the schema table.
-- Include every record from product and any reviews they have.
-- Return the product name, review rating and comments.  
-- Order by rating in ascending order.
SELECT name, rating, comments from production.product
	JOIN production.productreview ON production.product.productid=production.productreview.productid
	ORDER BY rating ASC;
-- USING
SELECT name, rating, comments from production.product
	JOIN production.productreview USING (productid)
	ORDER BY rating ASC;

-- Use a right join to combine workorder and product from production schema to bring back all products and any work orders they have.
-- Include the product name and workorder orderqty and scrappedqty fields.
-- Order by productid ascending.
SELECT name, orderqty, scrapreasonid from production.workorder
	RIGHT JOIN production.product ON production.workorder.productid=production.product.productid
	ORDER BY production.product.productid ASC
SELECT name, orderqty, scrapreasonid from production.workorder
	RIGHT JOIN production.product ON production.workorder.productid=production.product.productid
	WHERE orderqty IS NOT NULL AND scrapreasonid IS NOT NULL
	ORDER BY production.product.productid ASC
-- USING
SELECT name, orderqty, scrapreasonid from production.workorder
	RIGHT JOIN production.product USING (productid)
	ORDER BY production.product.productid ASC
SELECT name, orderqty, scrapreasonid from production.workorder
	RIGHT JOIN production.product USING (productid)
	WHERE orderqty IS NOT NULL AND scrapreasonid IS NOT NULL
	ORDER BY production.product.productid ASC
