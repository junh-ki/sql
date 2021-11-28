/* Main - northwind */

/* Union */
-- Combine the results of 2 or more queries.
-- Get a list of all customer and supplier company names
SELECT companyname FROM customers
	UNION
	SELECT companyname FROM suppliers;
-- UNION ALL doesn't remove duplicates
-- Find cities of all our customers and suppliers, with one record for each company's city
SELECT city FROM customers
	UNION
	SELECT city FROM suppliers;
SELECT city FROM customers
	UNION ALL
	SELECT city FROM suppliers;
-- Find all the distinct countries of all our customers and suppliers in alphabetical order
SELECT country FROM customers
	UNION
	SELECT country FROM suppliers
	ORDER BY country ASC;
-- Find all list of countries of our customers and suppliers, with a record for each one.
SELECT country FROM customers
	UNION ALL
	SELECT country FROM suppliers
	ORDER BY country ASC;

/* Intersect */
-- Find items that are both queries
-- Must have the same number of columns, column types must line up
-- Removes duplicates
-- Find all countries that we have both customers and suppliers in
SELECT country FROM customers
	INTERSECT
	SELECT country FROM suppliers;
-- INTERSECT ALL does not remove duplicates
-- Find the number of customer and supplier pairs that are in the same country,
-- the result tells you that we have 23 countries where we have customers that are in the same countries as the suppliers
SELECT COUNT(*) FROM
	(SELECT country FROM customers
		INTERSECT ALL
		SELECT country FROM suppliers) AS together
-- Pull back the distinct cities that we have suppliers and customers located in
SELECT city FROM customers
	INTERSECT
	SELECT city FROM suppliers;
-- Find the count of the number of customer and supplier pairs that are in the same city.
SELECT COUNT(*) FROM
	(SELECT city FROM customers
		INTERSECT ALL
		SELECT city FROM suppliers) AS same_cities;

/* Except */
-- Find items that are the first query but not the second
-- Must have the same number of columns, column types must line up
-- Removes duplicates
-- Find all countries that customers are in but no suppliers
SELECT country FROM customers
	EXCEPT
	SELECT country FROM suppliers;
-- EXCEPT ALL - Grab all values
-- Find the number of customer that are in a country without suppliers
SELECT COUNT(*) FROM
	(SELECT country FROM customers
		EXCEPT ALL
		SELECT country FROM suppliers) as lonely_customers;
-- Find cities where we have a supplier but not customer
SELECT city FROM suppliers
	EXCEPT
	SELECT city FROM customers;
-- How many customers do we have in cities without suppliers
SELECT COUNT(*) FROM
	(SELECT city FROM customers
		EXCEPT ALL
		SELECT city FROM suppliers) AS lonely_customers;
