/* Main - northwind */

/* Selecting all data from a table */

SELECT * FROM customers;
SELECT * FROM employees;

/* Selecting specific fields */

SELECT companyname, city, country FROM suppliers;
SELECT categoryname, description FROM categories;

/* Selecting distinct values */

SELECT DISTINCT country FROM customers;
SELECT DISTINCT city, country FROM customers;
SELECT DISTINCT region FROM suppliers;

/* Counting results */

SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(DISTINCT city) FROM suppliers; -- how many cities are our suppliers in?
SELECT COUNT(DISTINCT productid) FROM order_details; -- how many distinct products have been ordered?

/* Combining Fields in SELECT */

-- how long did it take to ship (list our customerid and difference between ship date and order date for all our orders.)
SELECT customerid, shippeddate - orderdate FROM orders;
-- select the amount spent on order details (price times quantity)
SELECT orderid, unitprice * quantity from order_details;

/* Practice - pagila */

-- Select all fields and all records from actor table
SELECT * FROM actor;

-- Select all fields and records from film table
SELECT * FROM film;

-- Select all fields and records from the staff table
SELECT * FROM staff;

-- Select address and district columns from address table
SELECT address, district FROM address;

-- Select title and description from film table
SELECT title, description FROM film;

-- Select city and country_id from city table
SELECT city, country_id FROM city;

-- Select all the distinct last names from customer table
SELECT DISTINCT last_name FROM customer;

-- Select all the distinct first names from the actor table
SELECT DISTINCT first_name FROM customer;

-- Select all the distinct inventory_id values from rental table
SELECT DISTINCT inventory_id FROM rental;

-- Find the number of films ( COUNT ).
SELECT COUNT(*) FROM film;

-- Find the number of categories.
SELECT COUNT(*) FROM category;

-- Find the number of distinct first names in actor table
SELECT COUNT(DISTINCT first_name) FROM actor;

-- Select rental_id and the difference between return_date and rental_date in rental table
SELECT rental_id, return_date - rental_date FROM rental;
