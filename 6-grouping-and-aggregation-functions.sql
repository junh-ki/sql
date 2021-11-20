/* Main - northwind */

/* Group By */
-- How many customers do we have in each country?
SELECT country, COUNT(*) FROM customers
	GROUP BY country
	ORDER BY COUNT(*) DESC;
-- You can do them with Joins
-- What is the number of products for each category?
SELECT categoryname, COUNT(*) FROM categories
	JOIN products ON products.categoryid=categories.categoryid
	GROUP BY categoryname
	ORDER BY COUNT(*) DESC;
-- You can use any aggregate function
-- What is the average number of items ordered for products ordered by the average amount?
SELECT productname, ROUND(AVG(quantity)) FROM products
	JOIN order_details ON products.productid=order_details.productid
	GROUP BY productname
	ORDER BY AVG(quantity) DESC;
-- How many suppliers in each country?
SELECT country, COUNT(*)
	FROM suppliers
	GROUP BY country
	ORDER BY COUNT(*) DESC;
-- Total value of each product sold for the year of 1997
SELECT productname, SUM(order_details.unitprice * quantity)
	FROM products
	JOIN order_details ON products.productid=order_details.productid
	JOIN orders ON order_details.orderid=orders.orderid
	WHERE orderdate BETWEEN '1997-01-01' AND '1997-12-31'
	GROUP BY productname
	ORDER BY SUM(order_details.unitprice * quantity) DESC;

/* Use HAVING to Filter Groups */
-- WHERE filters records before grouping
-- HAVING filters records after grouping
-- Find products that sold less than $2000
SELECT productname, SUM(quantity * order_details.unitprice) AS AmountBought 
	FROM products 
	JOIN order_details USING (productid) 
	GROUP BY productname 
	HAVING SUM(quantity * order_details.unitprice) < 2000
	ORDER BY AmountBought ASC;
-- Find customers that have bought more than $5000 of products
SELECT companyname, SUM(quantity * unitprice) AS AmountSpent
	FROM customers
	JOIN orders USING (customerid)
	JOIN order_details USING (orderid)
	GROUP BY companyname
	HAVING SUM(quantity * unitprice) > 5000
	ORDER BY AmountSpent ASC;
SELECT companyname, SUM(quantity * unitprice) AS AmountBought
	FROM customers
	NATURAL JOIN orders
	NATURAL JOIN order_details
	GROUP BY companyname
	HAVING SUM(quantity * unitprice) > 5000
	ORDER BY AmountBought ASC;
-- Find customers that have bought more than $5000 of products with order date in the first six months of the year of 1997
SELECT companyname, SUM(quantity * unitprice) AS AmountSpent
	FROM customers
	NATURAL JOIN orders
	NATURAL JOIN order_details
	WHERE orderdate > '1997-01-01' AND orderdate < '1997-06-30'
	GROUP BY companyname
	HAVING SUM(quantity * unitprice) > 5000
	ORDER BY AmountSpent ASC;

/* Grouping Sets */
-- GROUP BY GROUPING SETS( (field1), (field2), (field3, field4) )
SELECT categoryname, productname, SUM(od.unitprice * quantity)
	FROM categories
	NATURAL JOIN products
	NATURAL JOIN order_details AS od
	GROUP BY GROUPING SETS ((categoryname), (categoryname, productname))
	ORDER BY categoryname, productname;
-- Find total sales by both customer's companyname renamed as buyer 
-- and supplier's companyname renamed as supplier and order by buyer and supplier
SELECT customers.companyname AS buyer, suppliers.companyname AS supplier, SUM(quantity * order_details.unitprice)
	FROM customers
	NATURAL JOIN orders
	NATURAL JOIN order_details
	JOIN products USING (productid)
	JOIN suppliers USING (supplierid)
	GROUP BY GROUPING SETS ((buyer), (buyer, supplier))
	ORDER BY buyer, supplier;
-- Find total sales grouped by customer companyname and categoryname (must link to tables),
-- order by companyname, categoryname with NULLS FIRST
SELECT companyname, categoryname, SUM(quantity * order_details.unitprice)
	FROM customers
	NATURAL JOIN orders
	NATURAL JOIN order_details
	JOIN products USING (productid)
	JOIN categories USING (categoryid)
	GROUP BY GROUPING SETS ((companyname), (companyname, categoryname))
	ORDER BY companyname, categoryname
	NULLS FIRST;

/* Rollup */


/* Cube - Rollup On Steroids */

