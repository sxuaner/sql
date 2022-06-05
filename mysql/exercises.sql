
-- Naming convention: 
-- All user-defined names, such as table names, column names should be in lower case
-- ALL MySQL keywords should be in upper case


-- To drop a table
DROP TABLE IF EXISTS countries;
-- To create a table
CREATE TABLE countries(  -- Watch out for this paranthesis 
COUNTRY_ID varchar(2),
COUNTRY_NAME varchar(40),
REGION_ID decimal(10,0),
FOUNDATION_DATE date
);

-- how to get unique results
SELECT DISTINCT * FROM toys;

-- Using OR, AND to combine conditions
SELECT * FROM toys WHERE ID = 5 OR ID > 3;	-- ID is int type
SELECT * FROM toys WHERE ID = 5 AND ID > 3;	-- ID is int type


-- Negation with NOT, informations which are not in the result set in the where clause will be returned.alter
SELECT * FROM toys WHERE NOT ID = 5 AND ID > 3;	-- ID is int type

-- NOT < is >=. Watch this

-- get all column infomation of toys table
DESC toys;

-- select all rows with id in the range of 3-5.
-- Accoring to https://dev.mysql.com/doc/refman/8.0/en/non-typed-operators.html
-- IN() is an operator that tests whether a value is within a set of values

-- expr IN (value,...)
-- Returns 1 (true) if expr is equal to any of the values in the IN() list, else returns 0 (false).
SELECT * FROM toys WHERE ID IN (3, 4, 5);	-- ID is int type
-- NOT IN()
SELECT * FROM toys WHERE ID NOT IN (3, 4, 5);


-- BETWEEN is discouraged to use because of ambiguity

-- Comparision between dates??
SELECT * FROM countries WHERE FOUNDATION_DATE BETWEEN '1991-01-01' AND '2022-01-01';

-- To match a pattern using LIKE( case insensitive), MySQL provides 2 wildcard characters for constructing patterns
-- % indicates any number of any character or sign.
-- underscore _ matches a single character ( and only characters)


-- REGEX
-- Selecting all the countries whose name contains C or c??
SELECT * FROM countries WHERE COUNTRY_NAME REGEXP 'C';
-- ^ matches the beginning of a string
-- $ matches the end
-- | is logical or : select strings that contain pip or mac : 'pip|mac' 
-- [caf]ina matches : cina, aina,fina
-- [a-h] matches one of the letters from a to h

-- To check for null values
SELECT * FROM countries WHERE COUNTRY_NAME IS NULL;
-- Use case: 
-- In the order table of a online shopping website, the orders which have not yet been shipped have null values in 
-- both the shipper_id and shipping_date


-- What is the default sorting mechanism in mysql? on primary key.
-- by what are queries sorted by default? Primary key

-- DESC means descending sorting 
SELECT * FROM countries ORDER BY COUNTRY_ID DESC;

-- Multiple sorting parameters are also possible
-- Sort by state in asencding order and country_id in descending order
SELECT * FROM countries ORDER BY STATE, COUNTRY_ID DESC;

-- Alias can be used in where clause
-- CONCAT() is used to combine 2 or more strings.
SELECT *, CONCAT(COUNTRY_NAME, '-EARTH') AS name_on_earth FROM countries  ORDER BY name_on_earth;


-- -------------   LIMIT clause syntax:  -------------
-- SELECT select_list FROM table_name LIMIT [offset,] row_count;
-- In this syntax:
-- The offset specifies the offset of the first row to return. The offset of the first row is 0, not 1.
-- The row_count specifies the maximum number of rows to return.

-- -------------------------- INNER JOIN --------------------------
-- INNER JOIN and , (comma) are semantically equivalent in the absence of a join condition: both produce a 
-- Cartesian product between the specified tables (that is, each and every row in the first table is joined 
-- to each and every row in the second table).

-- INNER JOIN is the defaul, so only JOIN is enough
-- t and c are aliases
SELECT * from toys AS t INNER JOIN countries AS c ON t.id = c.country_id; -- usually 2 same IDs are used
-- Here all columns are selected from the joined table

-- Join 2 tables from different dbs. Prefix the tables with db names

-- Learn how to self join( i.e joining the table itself)
-- Learn how to use tool tables to query result. 
-- By tool tables I mean some simple table for joining
 
-- In MySQL, JOIN, CROSS JOIN, and INNER JOIN are syntactic equivalents (they can replace each other). 
-- In standard SQL, they are not equivalent. INNER JOIN is used with an ON clause, CROSS JOIN is used otherwise.

-- Composite Primary key

-- Implicit Inner join( A where clause must exist)
SELECT * FROM foods, countries WHERE foods.itemid = countries_id;

-- -------------------------- Cross join: every record in table A is joined with table B --------------------------

-- --------------------------  Outer joins -------------------------- 
-- Left outer join: all the records in the left table and the matching records in the right table

-- Outer joins are for finding records that may not have a match in the other table. As such, you have to specify 
-- which side of the join is allowed to have a missing record.????

-- Full outer join?

-- -----------------------------  Inner Join and outer join differences ----------------------- -------------
-- An inner join of A and B gives the result of A intersect B, i.e. the inner part of a Venn diagram intersection.
-- An outer join of A and B gives the results of A union B, i.e. the outer parts of a Venn diagram union.
-- Left|Right join are short for left outer/right outer join
DROP TABLE join_example;
-- Suppose you have two tables, with a single column each, and data as follows:
CREATE TABLE a (
	num int
);
CREATE TABLE b (
	num int
);
INSERT INTO a (num) VALUES (1);
INSERT INTO a (num) VALUES (2);
INSERT INTO a (num) VALUES (3);
INSERT INTO a (num) VALUES (4);
INSERT INTO b (num) VALUES (3);
INSERT INTO b (num) VALUES (4);
INSERT INTO b (num) VALUES (5);
INSERT INTO b (num) VALUES (6);
-- Note that (1,2) are unique to A, (3,4) are common, and (5,6) are unique to B.


-- ------------- Left outer join -------------
-- A left outer join will give all rows in A, plus any common rows in B.
select * from a LEFT OUTER JOIN b on a.num = b.num;

-- -- how to alias a.num and b.num here?
SELECT a.num AS a, b.num AS b FROM a LEFT OUTER JOIN b ON a.num = b.num;

-- This is inner join
select a.*, b.*  from a,b where a.num = b.num;
-- query result:
-- a |  b
-- --+-----
-- 1 | null
-- 2 | null
-- 3 |    3
-- 4 |    4

-- Left outer join to Inner join
SELECT * FROM a LEFT OUTER JOIN B ON a.num = b.num WHERE b.num IS NOT NULL; 


-- ------------- Right outer join -------------
-- A right outer join will give all rows in B, plus any common rows in A.
select * from a RIGHT OUTER JOIN b on a.num = b.num;
select a.*, b.*  from a,b where a.num = b.num;
-- query result:
-- a    |  b
-- -----+----
-- 3    |  3
-- 4    |  4
-- null |  5
-- null |  6
-- Best practice: avoid mixing right and left outer join. A WHERE clause can be used instead of right outer join.
-- RIGHT JOIN works analogously to LEFT JOIN. To keep code portable across databases, it is recommended that you use LEFT JOIN 
-- instead of RIGHT JOIN.

-- ------------- Full outer join -------------
-- Mysql seems not to support full outer join. It must be done with UNION
-- A full outer join will give you the union of A and B, i.e. all the rows in A and all the rows in B. If something 
-- in A doesn't have a corresponding datum in B, then the B portion is null, and vice versa.
select * from a FULL JOIN b;
select * from a FULL JOIN b ON a.num = b.num;
-- query result:
--  a   |  b
-- -----+-----
--    1 | null
--    2 | null
--    3 |    3
--    4 |    4
-- null |    6
-- null |    5

-- ------------- USING -------------
-- The USING(join_column_list) clause names a list of columns that must exist in both tables. If tables a and b both contain columns c1, c2, 
-- and c3, the following join compares corresponding columns from the two tables:
-- !!USING only returns 1 column!!!!!
SELECT * FROM a LEFT OUTER JOIN b USING (num);
SELECT * FROM a RIGHT OUTER JOIN b USING (num);
SELECT * FROM a JOIN b USING (num);
