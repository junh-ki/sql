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


/* Grouping Sets */


/* Rollup */


/* Cube - Rollup On Steroids */

