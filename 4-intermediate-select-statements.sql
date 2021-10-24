/* Main - northwind */

/* ORDERED BY */
SELECT DISTINCT country FROM suppliers;
SELECT DISTINCT country FROM suppliers ORDER BY country ASC;
SELECT DISTINCT country FROM suppliers ORDER BY country DESC;
SELECT DISTINCT country, city FROM suppliers ORDER BY country ASC, city DESC;
SELECT DISTINCT country, city FROM suppliers ORDER BY country ASC, city ASC;
SELECT DISTINCT country, city FROM suppliers ORDER BY country DESC, city ASC;
-- get a list of product names and unit prices order by price highest to lowest and product name a to z (if they have same price)
SELECT productname, unitprice FROM products ORDER BY unitprice DESC, productname ASC;

/* Using MIN and MAX Functions */
SELECT MIN(orderdate) FROM orders WHERE shipcountry='Italy';
SELECT MAX(shippeddate) FROM orders WHERE shipcountry='Canada';
-- find the order that took the longest time sent to France based on order date versus ship date
SELECT MAX(shippeddate - orderdate) FROM orders WHERE shipcountry='France';
SELECT * FROM orders WHERE (shippeddate - orderdate) = (SELECT MAX(shippeddate - orderdate) FROM orders WHERE shipcountry='France');

/* Using AVG and SUM */
SELECT AVG(freight) FROM orders WHERE shipcountry='Brazil';
-- how many individual items of Tofu (productid=14) were ordered
SELECT SUM(quantity) FROM order_details WHERE productid=14;
-- what was the average number of Steeleye Stout (productid=35) per order
SELECT AVG(quantity) FROM order_details WHERE productid=35;

/* LIKE to Match Patterns */
-- WHERE suppliername LIKE 'a%'; - all suppliers names that start with a
-- WHERE suppliername LIKE '%e'; - all suppliers names that end with e
-- WHERE suppliername LIKE '%bob%'; - all supplier names with bob in name somewhere
-- WHERE suppliername LIKE 'A%i'; - all supplier names that start with A and end with i
SELECT companyname, contactname FROM customers WHERE contactname LIKE 'D%';
-- _stands for any single character
-- WHERE suppliername LIKE '_a%'; - has a as second letter
-- WHERE suppliername LIKE 'E_%_%'; - starts with E and has at least 2 other letters
-- which of our suppliers have 'or' as the 2nd and 3rd letters in the company name
SELECT * FROM suppliers WHERE companyname LIKE '_or%';
-- which customer company names end in 'er'?
SELECT * FROM customers WHERE companyname LIKE '%er';

/* Renaming Columns With Alias */
SELECT unitprice * quantity FROM order_details;
SELECT unitprice * quantity AS TotalSpent FROM order_details;
-- this won't work
SELECT unitprice * quantity AS TotalSpent FROM order_details WHERE TotalSpent > 10;
-- this one will
SELECT unitprice * quantity AS TotalSpent FROM order_details ORDER BY TotalSpent DESC;
-- calculate our inventory value of products (need unitprice and unitsinstock fields) and return as TotalInventory and order by this column desc
SELECT unitprice * unitsinstock AS TotalInventory FROM products ORDER BY TotalInventory DESC;

/* LIMIT to Control Number of Records Returned */
SELECT productid, unitprice * quantity AS TotalCost FROM order_details ORDER BY TotalCost DESC LIMIT 3;
-- calculate the 2 products with the least inventory in stock by total dollar amount of inventory
SELECT productname, unitprice * unitsinstock AS TotalInventory FROM products ORDER BY TotalInventory ASC LIMIT 2;

/* NULL Values */
SELECT COUNT(*) FROM customers WHERE region IS NULL;
SELECT COUNT(*) FROM suppliers WHERE region IS NOT NULL;
-- how many orders did not have a ship region
SELECT COUNT(*) FROM orders WHERE shipregion IS NULL;

/* Practice - AdventureWorks */

-- Return the name, weight, and productnumber of all the products ordered by weight from lightest to heaviest.
-- (Remember to use schema to reach table.  It is in production schema.)
SELECT name, weight, productnumber FROM production.product ORDER BY weight ASC;

-- Return the records from productvendor for productid = 407 in order of averageleadtime from shortest to longest.
-- (You'll have to figure out which schema this is in.)
SELECT * FROM purchasing.productvendor WHERE productid=407 ORDER BY averageleadtime ASC;

-- Find all the salesorderdetail records for productid 799 and order them by largest orderqty to smallest.
SELECT * FROM sales.salesorderdetail WHERE productid=799 ORDER BY orderqty DESC;

-- What is the largest discount percentage offered in the specialoffer table.
SELECT MAX(discountpct) FROM sales.specialoffer;
SELECT * FROM sales.specialoffer WHERE discountpct = (SELECT MAX(discountpct) FROM sales.specialoffer);

-- Find the smallest number of sickleavehours for an employee.
SELECT MIN(sickleavehours) FROM humanresources.employee;
SELECT * FROM humanresources.employee WHERE sickleavehours = (SELECT MIN(sickleavehours) FROM humanresources.employee);

-- Find the largest rejected quantity in the purchaseorderdetail table.
SELECT MAX(rejectedqty) FROM purchasing.purchaseorderdetail;
SELECT * FROM purchasing.purchaseorderdetail WHERE rejectedqty = (SELECT MAX(rejectedqty) FROM purchasing.purchaseorderdetail);

-- Find the average rate from employeepayhistory table.
SELECT AVG(rate) FROM humanresources.employeepayhistory;

-- Find the average standardcost in the productcosthistory table for productid 738.
SELECT AVG(standardcost) FROM production.productcosthistory WHERE productid=738;

-- Find the sum of scrappedqty from the workorder table for productid 529.
SELECT SUM(scrappedqty) FROM production.workorder WHERE productid=529;

-- Find all vendor names with a name that starts with letter G.
SELECT name FROM purchasing.vendor WHERE name LIKE 'G%';

-- Find all vendor names that have the word Bike in them.
SELECT name FROM purchasing.vendor WHERE name LIKE '%Bike%';

-- Search the person table for every firstname that has t as a second letter.
SELECT firstname FROM person.person WHERE firstname LIKE '_t%';

-- Return the first 20 records from emailaddress table.
SELECT * FROM person.emailaddress LIMIT 20;

-- Return the first 2 records from productcategory table.
SELECT * FROM production.productcategory LIMIT 2;

-- How many product records have a missing weight value.
SELECT COUNT(*) FROM production.product WHERE weight IS NULL;

-- How many person records have an additionalcontactinfo field that has a value.
SELECT COUNT(*) FROM person.person WHERE additionalcontactinfo IS NOT NULL;
