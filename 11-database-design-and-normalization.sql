/* Main - northwind */

/* Design Process Overview */
-- Three Types of Relationships
---- 1. One-to-One: like profile and description (split due to impact on searching)
---- 2. One-to-Many: orders to order_details
---- 3. Many-to-Many: actors and movies
-- Three types of Fields in Bad Design
---- 1. Multipart field - like full name
---- 2. Multivalued field - Children array
---- 3. Calculated field - Total spent that is price * quantity
-- Normalization
---- Eliminating duplicate/redundant data
---- Breaking large tables into smaller ones
---- Making sure that inserting/updating/deleting data doesn't cause problems

/* Database Terminology */
-- Relational Databases
---- Data is stored in relations based on relational model
-- OLTP (Online Transaction Processing)
---- Used to handle current data that is being entered and changed
-- OLAP (Online Analytical Processing)
---- Primarily used for analysis of data that is being changed or used real time
-- Relations = Tables
---- Relation was meant in a mathematical sense, still see the term used that way
-- Tuples = Rows
---- Consists of all the fields. Each table (relation) has many rows (tuples)
-- Attributes = Fields = Columns
---- In PostgreSQL, fields are referred to as columns
---- It should contain one, and only one, value
---- Name should clearly identify what is contained 
-- Views
---- Virtual tables that use fields from base tables
-- Primary Key
---- Field that uniquely identifies each record in table
---- This identity is used throughout the database to link information back to row in table
-- Foreign Key
---- When the primary key is added to another table
---- It links the information back to original table and record
-- Null Values
---- It stands for missing or unknown values
---- Not an empty string ""
---- Affects a lot of calculations, can't add unknowns to knowns
---- When used correctly, lets you know what you don't know
-- Domain = Field Specification
---- General: name, description, parent table
---- Physical: data type, length, display format
---- Logical: required values, range of values, default values
-- Data Tables vs Validation Tables
---- Data tables: normal tables with records that change frequently
---- Validation tables: also called lookup tables, static values
-- Linking Tables / Associative Tables
---- Used to create many-to-many relationships
---- Students-Entrollments-Classes
-- Data Integrity
---- Used to refer to the validity, consistency and accuracy of data in a database
-- Four Levels of Data Integrity
---- 1. Table (Entity) Level: No duplication rows and a good primary key
---- 2. Field (Domain) Level: Structures of fields solid, values are accurate, same type field are defined the same
---- 3. Relationship (Referential) Level: Relationships between tables are sound
---- 4. Business Rules: Requirements for business are enforced

/* A Design Process */
-- Seven Step Process
---- 1. Define mission statement and objectives
------ Mission statement: purpose of database and gives focus
------ Mission objectives: list of tasks people do using the database
---- 2. Analyze current database and workflow
------ Looking for information being used to run the business
------ Can be paper forms used or information being written down
------ Interviewing management and employees
------ Create a list of fields you circulate to everyone to discuss and give feedback
---- 3. Create the database structure
------ Define tables
------ Define fields and assign to tables
------ Define primary keys
------ Define field specifications
---- 4. Create table relationships
------ Which tables are related?
------ Establish foreign keys
------ Focus on relationship-level integrity
---- 5. Handle business rules
------ Use customer interviews to find company rules about how business works
------ Employees have visibility into individual areas
------ Managers have visibility into overall/general rules
------ Use lookup tables, functions, triggers and constraints to enforce rules
---- 6. Define views
------ Interview everyone to see who should see what information or uses certain information consistently
------ Summary information versus details
------ Create views to support
---- 7. Review data integrity
------ Do fields have domain integrity?
------ Do tables have entity integrity?
------ Do table relationships have referential integrity?
------ Are the business rules enforced?

/* Analyzing Current Systems */
-- Looking for Nouns
---- Example: I answer the phone and talk to a 'customer' that wants to book an 'appointment' with a 'stylist'
---- Three Nouns: 'customer', 'appointment', 'stylist'
-- Nouns Become Tables
---- Each table represents a noun or an event
-- Now Drill into Nouns
---- Look for characteristics
---- Ask questions like
------ "What do you need to know about someone you want to go out with?"
------ "What do you need to fulfill a customer order?"
-- Characteristics Become Fields
---- Look for the atomic information needed (information that is entirely independent from others)
---- Double check with everyone that you have all the information needed for the business to succeed
-- Ask about future information needed
---- What would make the processes run better?
---- What decisions need to be made?
---- What new information is now available?
-- Build a preliminary list of tables/fields
---- Circulate to all the stakeholders
---- Make sure you haven't missed anything
---- Remove fields you can calculate from other fields

/* Create Table Structure */


/* Establishing Keys */


/* Specifying Fields */


/* Relationships Between Tables */


/* Business Rules */


/* Establish Needed Views */


/* Double Checking Data Integrity */

