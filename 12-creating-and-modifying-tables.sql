/* Main - northwind */

/*** IMPORTANT! ***/
--* Integer Data Types
-- smallint (2 bytes): -32768 ~ 32768
-- integer (4 bytes): -2147483648 ~ 2147483647
-- bigint (8 bytes): -9223372036854775808 ~ 9223372036854775807
-- smallserial (2 bytes): 1 ~ 32767
-- serial (4 bytes): 1 ~ 2147483647
-- bigserial (8 bytes): 1 ~ 9223372036854775807
--* Arbitrary Precision Data Types
-- decimal (variable): 
---- up to 131072 digits before the decimal point;
---- up to 16383 digits after the decimal point;
-- numeric (variable):
---- up to 131072 digits before the decimal point;
---- up to 16383 digits after the decimal point;
--* Floating Point Data Types
-- real (4 bytes): 6 decimal digits precision
-- double precision (8 bytes): 15 decimal digits precision
--* Character Data Types
-- character varying(n), varchar(n): Variable length, with limit
-- character(n), char(n): Fixed length
-- text: Variable unlimited length
--* Data/Time Data Types
-- timestamp (8 bytes): 4713 B.C. ~ 294,276 AD
-- date (4 bytes): 4713 B.C. ~ 294,276 AD (NO TIME)
-- time (8 bytes): 00:00:00 ~ 24:00:00 (NO DATE)
-- interval (16 bytes): -178,000,000 years ~ +178,000,000 years
--* Boolean Data Type
-- boolean (1 byte): true or false

/* CREATE TABLE */
-- For our newsletter subscribers:
-- Fields should be: first name, last name, email, signup date, frequency, is a customer
CREATE TABLE subscribers (
	firstname varchar(200),
	lastname varchar(200),
	email varchar(250),
	signupdate timestamp,
	frequency integer,
	iscustomer boolean
);
-- Create a table for returns
-- Should have id for the record, customerid, date returned, productid, quantity and orderid
CREATE TABLE returns (
	returnid serial,
	customerid char(5),
	datereturned timestamp,
	productid int,
	quantity smallint,
	orderid integer
);

/* ALTER TABLE - Part One */
--* Scenario One: Rename Field
-- ALTER TABLE table_name
-- RENAME column_oldname TO column_newname;
-- Rename Subscribers Field
-- Change firstname to first_name
ALTER TABLE subscribers
	RENAME firstname TO first_name;
-- On returns table rename datereturned to return_date
ALTER TABLE returns
	RENAME datereturned TO return_dated;
--* Scenario Two: Rename Table
-- ALTER TABLE old_table_name
-- RENAME TO new_table_name;
-- Rename Subscribers To email_subscribers
ALTER TABLE subscribers
	RENAME TO email_subscribers;
-- Change returns to bad_orders
ALTER TABLE returns
	RENAME TO bad_orders;

/* ALTER TABLE - Part Two */
--* Scenario Three: Add a Field
-- ALTER TABLE table_name
-- ADD column datatype;
-- Add new column last_visit_date (date/time) to email_subscribers table
ALTER TABLE email_subscribers
	ADD COLUMN last_visit_date timestamp;
-- On bad_orders table add a text field called reason
ALTER TABLE bad_orders
	ADD COLUMN reason text;
--* Scenario Four: Delete a Field
-- ALTER TABLE table_name
-- DROP COLUMN column;
-- Remove column last_visit_date from email subscribers table
ALTER TABLE email_subscribers
	DROP COLUMN last_visit_date;
-- On bad_orders table remove reason field
ALTER TABLE bad_orders
	DROP COLUMN reason;

/* ALTER TABLE - Part Three */
--* Scenario Five: Change Data Type
-- ALTER TABLE table_name
-- ALTER COLUMN column SET DATA TYPE datatype;
-- Resize the email field in email_subscribers table to varchar with a length of 225
ALTER TABLE email_subscribers
	ALTER COLUMN email SET DATA TYPE varchar(225);
-- On bad_orders table change the quantity field to int (currently small int)
ALTER TABLE bad_orders
	ALTER COLUMN quantity SET DATA TYPE int;
-- What are we ignoring for now: 
-- Constraints and Triggers

/* DROP TABLE */
-- DROP TABLE table_name;
-- Get rid of email_subscribers table
DROP TABLE email_subscribers;
-- Drop the bad_orders table
DROP TABLE bad_orders;
