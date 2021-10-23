/* Main - AdventureWorks */

-- SELECT * FROM product; -- this doesn't work because in this case the search path goes to public not to the schema, production, which has the table, product.
SELECT * FROM production.product;
-- select everything from the vendor table in purchasing schema
SELECT * FROM purchasing.vendor;
