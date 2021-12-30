/* Main - northwind */

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
-- * Scenario One: Rename Field
-- ALTER TABLE table_name
-- RENAME column_oldname TO column_newname;
-- Rename Subscribers Field
-- Change firstname to first_name
ALTER TABLE subscribers
	RENAME firstname TO first_name;
-- On returns table rename datereturned to return_date
ALTER TABLE returns
	RENAME datereturned TO return_dated;
-- * Scenario Two: Rename Table
-- ALTER TABLE old_table_name
-- RENAME TO new_table_name;
-- Rename Subscribers To email_subscribers
ALTER TABLE subscribers
	RENAME TO email_subscribers;
-- Change returns to bad_orders
ALTER TABLE returns
	RENAME TO bad_orders;

/* ALTER TABLE - Part Two */
-- * Scenario Three: Add a Field
-- ALTER TABLE table_name
-- ADD column datatype;
-- Add new column last_visit_date (date/time) to email_subscribers table
ALTER TABLE email_subscribers
	ADD COLUMN last_visit_date timestamp;
-- On bad_orders table add a text field called reason
ALTER TABLE bad_orders
	ADD COLUMN reason text;
-- * Scenario Four: Delete a Field
-- ALTER TABLE table_name
-- DROP COLUMN column;
-- Remove column last_visit_date from email subscribers table
ALTER TABLE email_subscribers
	DROP COLUMN last_visit_date;
-- On bad_orders table remove reason field
ALTER TABLE bad_orders
	DROP COLUMN reason;

/* ALTER TABLE - Part Three */
-- * Scenario Five: Change Data Type
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
