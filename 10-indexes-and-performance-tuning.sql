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
DROP TABLE IF EXISTS performance_test;
CREATE TABLE performance_test (
	id serial,
	location text
);
INSERT INTO performance_test(location)
	SELECT md5(random()::text) FROM generate_series(1, 10000000);
EXPLAIN ANALYZE SELECT * FROM performance_test
	WHERE id=2000000;
ANALYZE performance_test;
EXPLAIN ANALYZE SELECT * FROM performance_test
	WHERE id=2000000;

/* How is Query Plan Cost calculated */
SET max_parallel_workers_per_gather = 0;
EXPLAIN SELECT * FROM performance_test WHERE location LIKE 'ab%';
-- Two Basics Types of Costs
-- 1. I/O Costs - reading and writing to disk
-- 2. CPU Costs - processing data
-- (Number of relation pages * seq_page_cost) + (Number of rows * cpu_tuple_cost) + (Number of rows * cpu_operator_cost)
-- How to see table size
SELECT pg_relation_size('performance_test'),
	pg_size_pretty(pg_relation_size('performance_test'));
-- Where to find relation pages
SELECT relpages, pg_relation_size('performance_test') / 8192
	FROM pg_class WHERE relname='performance_test';
-- How to find I/O cost used by plan
SHOW seq_page_cost;
-- Total predicted I/O costs
SELECT relpages * current_setting('seq_page_cost')::numeric
	FROM pg_class WHERE relname='performance_test';
-- CPU costs depend on rows processed
-- How to find rows in table:
-- SELECT reltuples FROM pg_class WHERE relname='performance_test';
SELECT relpages * current_setting('seq_page_cost')::numeric, reltuples
	FROM pg_class WHERE relname='performance_test';
-- How to find CPU cost used by plan
SHOW cpu_tuple_cost;
SHOW cpu_operator_cost;
-- Total predicted CPU costs
SELECT relpages * current_setting()::numeric +
	reltuples * current_setting('cpu_tuple_cost')::numeric +
	reltuples * current_setting('cpu_operator_cost')::numeric
	FROM pg_class WHERE relname='performance_test';
SELECT relpages * current_setting('seq_page_cost')::numeric +
	(reltuples * (current_setting('cpu_tuple_cost')::numeric +
		current_setting('cpu_operator_cost')::numeric))
	FROM pg_class WHERE relname='performance_test';
-- Add parallelization back
SET max_parallel_workers_per_gather = 2;
EXPLAIN SELECT * FROM performance_test WHERE location LIKE 'ab%';
-- Some additional cost considerations
-- Cost of setting up each thread:
SHOW parallel_setup_cost;
-- Cost of communicating each row:
SHOW parallel_tuple_cost;

/* Using indexes on more than one field */
-- Create another column
ALTER TABLE performance_test
	ADD COLUMN name text;
UPDATE performance_test SET name=md5(location);
EXPLAIN ANALYZE SELECT * FROM performance_test
	WHERE location LIKE 'df%' AND  name LIKE 'cf%';
-- Create an index on both columns
CREATE INDEX idx_performance_test_location_name
	ON performance_test (location, name);
EXPLAIN ANALYZE SELECT * FROM performance_test
	WHERE location LIKE 'df%' AND  name LIKE 'cf%';
-- Order matters for searches with one column
EXPLAIN ANALYZE SELECT * FROM performance_test WHERE name LIKE 'cf%';
EXPLAIN ANALYZE SELECT * FROM performance_test WHERE location LIKE 'df%';
-- It's recommended to order the columns as they are already ordered

/* Expression indexes */


/* Types of indexes */


/* Speeding up Text Matching */

