/* Main - northwind */

/* Searching for specific text */
SELECT companyname FROM suppliers WHERE city='Berlin';
SELECT companyname, contactname FROM customers WHERE country='Mexico';

/* Searching numeric fields */
SELECT COUNT(*) FROM orders WHERE employeeid=3;
SELECT COUNT(*) FROM order_details WHERE quantity>20;
SELECT COUNT(*) FROM orders WHERE freight>=250;

/* Searching date fields */
SELECT COUNT(*) FROM orders WHERE orderdate >= '1998-01-01'; -- this counts orders after this specific time
SELECT COUNT(*) FROM orders WHERE shippeddate < '1997-07-05'; -- how many orders shipped before July 5, 1997

/* WHERE using logical AND operator */
SELECT COUNT(*) FROM orders WHERE shipcountry='Germany'; -- 122
SELECT COUNT(*) FROM orders WHERE freight > 100; -- 187
SELECT COUNT(*) FROM orders WHERE shipcountry='Germany' AND freight > 100; -- 32
-- distinct customers where orders were shipped via United Package (id=2) and the ship country is Brazil
SELECT DISTINCT(customerid) FROM orders WHERE shipvia=2 AND shipcountry='Brazil';

/* WHERE using logical OR operator */
SELECT COUNT(*) FROM customers WHERE country='USA';
SELECT COUNT(*) FROM customers WHERE country='Canada';
SELECT COUNT(*) FROM customers WHERE country='USA' OR country='Canada';
SELECT COUNT(*) FROM suppliers WHERE country='Germany';
SELECT COUNT(*) FROM suppliers WHERE country='Spain';
SELECT COUNT(*) FROM suppliers WHERE country='Germany' OR country='Spain';
SELECT COUNT(*) FROM orders WHERE shipcountry='USA' OR shipcountry='Brazil' OR shipcountry='Argentina';

/* WHERE using logical NOT operator */
SELECT COUNT(*) FROM customers WHERE NOT country='France';
SELECT COUNT(*) FROM suppliers WHERE NOT country='USA';

/* WHERE combining AND, OR, and NOT */
SELECT COUNT(*) FROM orders WHERE shipcountry='Germany' AND (freight < 50 OR freight > 175);
-- how many orders shipped to Canada or Spain and shippeddate after May 1, 1997
SELECT COUNT(*) FROM orders WHERE (shipcountry='CANADA' OR shipcountry='Spain') AND shippeddate > '1997-05-01';

/* Using BETWEEN */
-- (WHERE freight BETWEEN 50 AND 100;) equals (WHERE freight >= 50 AND freight <= 100;)
SELECT COUNT(*) FROM order_details WHERE unitprice BETWEEN 10 AND 20;
-- how many oders shipped between June 1, 1996 and September 30, 1996
SELECT COUNT(*) FROM orders WHERE shippeddate BETWEEN '1996-06-01' AND '1996-09-30';

/* Using IN */
-- (WHERE id IN (2,3,22,33,88);) equals (WHERE id=2 OR id=3 OR id=22 OR id=33 OR id=88;)
SELECT COUNT(*) FROM suppliers WHERE country IN ('Germany', 'France', 'Spain', 'Italy');
-- how many products do we have in categoryid 1 or 4 or 6 or 7
SELECT COUNT(*) FROM products WHERE categoryid IN (1, 4, 6, 7);

/* Practice - usda */

-- Select all records from data_src which came from the journal named 'Food Chemistry'.
SELECT * FROM data_src WHERE journal='Food Chemistry';

-- Select record from nutr_def where nutrdesc is Retinol.
SELECT * FROM nutr_def WHERE nutrdesc='Retinol';

-- Find all the food descriptions (food_des) records for manufacturer Kellogg, Co. (must include punctuation for exact match).
SELECT * FROM food_des WHERE manufacname='Kellogg, Co.';

-- Find the number of records in data sources (data_src) that were published after year 2000 (it is numeric field).
SELECT COUNT(*) FROM data_src WHERE year > 2000;

-- Find the number of records in food description that have a fat_factor < 4.
SELECT COUNT(*) FROM food_des WHERE fat_factor < 4;

-- Select all records from weight table that have gm_weight of 190.
SELECT * FROM weight WHERE gm_wgt=190;

-- Find the number of records in food description table that have pro_factor greater than 1.5 and fat_factor less than 5.
SELECT COUNT(*) FROM food_des WHERE pro_factor > 1.5 AND fat_factor < 5;

-- Find the record in data source table that is from year 1990 and the journal Cereal Foods World.
SELECT * FROM data_src WHERE year=1990 AND journal='Cereal Foods World';

-- Select count of weights where gm_wgt is greater than 150 and less than 200.
SELECT COUNT(*) FROM weight WHERE gm_wgt > 150 AND gm_wgt < 200;

-- Select the records in nutr_def table (nutrition definitions) that have units of kj or kcal.
SELECT * FROM nutr_def WHERE units='kj' OR units='kcal';
SELECT * FROM nutr_def WHERE units IN ('kj', 'kcal');

-- Select all records from data source table (data_src) that where from the year 2000 or the journal Food Chemistry.
SELECT * FROM data_src WHERE year=2000 OR journal='Food Chemistry';

-- How many records in food_des are not about food group Breakfast Cereals.
-- The field fdgrp_cd is an id field and you will have to find it in fd_group for fddrp_desc = ' Breakfast Cereals'.
SELECT * FROM fd_group WHERE fddrp_desc = 'Breakfast Cereals'; -- fdgrp_cd = 0800
SELECT COUNT(*) FROM food_des WHERE NOT fdgrp_cd='0800';

-- Find all the records in data sources that where between 1990 and 2000 and either 'J. Food Protection' or 'Food Chemistry'.
SELECT * FROM data_src WHERE year BETWEEN 1990 AND 2000 AND (journal='J. Food Protection' or journal='Food Chemistry');
SELECT * FROM data_src WHERE year BETWEEN 1990 AND 2000 AND (journal IN ('J. Food Protection', 'Food Chemistry'));

-- Use BETWEEN syntax to find number of weight records that weight between 50 and 75 grams (gm_wgt).
SELECT * FROM weight WHERE gm_wgt BETWEEN 50 AND 75;

-- Select all records from the data source table that were published in years 1960,1970,1980,1990, and 2000.  Use the IN syntax.
SELECT * FROM data_src WHERE year in (1960, 1970, 1980, 1990, 2000);
