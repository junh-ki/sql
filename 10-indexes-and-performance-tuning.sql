/* Main - northwind */

/* CREATE INDEX */
-- Create an index on employeeid field of employees table. Should be UNIQUE.
CREATE UNIQUE INDEX idx_employees_employeeid
	ON employees (employeeid);
-- On orders create a single index on two fields customerid and orderid.
CREATE INDEX idx_orders_customerid_orderid;
	ON orders (customerid, orderid);

/* DROP INDEX */
-- Drop idx_employees_employeeid index on employees table
DROP INDEX idx_employees_employeeid;
-- Drop idx_orders_customerid_orderid index on orders table
DROP INDEX idx_orders_customerid_orderid;

/* How to kill Runaway queries */
-- Make a purposeful mistake that's going to run forever
DROP TABLE IF EXISTS performance_test;
CREATE TABLE performance_test (
	id serial,
	location text
);
INSERT INTO performance_test (location)
	SELECT 'Katmandu, Nepal' FROM generate_series(1, 500000000);
-- Take care of your mistake on a system level
SELECT * FROM pg_stat_activity WHERE state='active';
-- Copy the PID (88369)
SELECT pg_cancel_backend(88369);

/* Uing Explain to see query plan */
DROP TABLE IF EXISTS performance_test;
CREATE TABLE performance_test (
	id serial,
	location text
);
INSERT INTO performance_test (location)
	SELECT md5(random()::text) FROM generate_series(1, 10000000);
-- Using simple queries on the large table
SELECT COUNT(*) FROM performance_test;
SELECT * FROM performance_test WHERE id=2000000;
-- Using explain queries on the large table
EXPLAIN SELECT COUNT(*) FROM performance_test;
EXPLAIN SELECT * FROM performance_test WHERE id=2000000;
CREATE INDEX idx_performance_test_id ON performance_test (id);
SELECT * FROM performance_test WHERE id=2000000;
EXPLAIN SELECT * FROM performance_test WHERE id=2000000; -- improved
SELECT COUNT(*) FROM performance_test; -- not improved
EXPLAIN SELECT COUNT(*) FROM performance_test; -- reiterate

/* Use Analyze to update table statistics */


/* How is Query Plan Cost calculated */


/* Using indexes on more than one field */


/* Expression indexes */


/* Types of indexes */


/* Speeding up Text Matching */

