-- =================== Definitions ===================

-- 标量函数 
-- what is scalar function?
-- A scalar function is a function that operates on a single value and returns a single value. It can be used in SQL statements to perform operations on data.
-- A scalar function is a function that returns a single value (one value per row), rather than a table or set of values. Examples include UPPER(), LOWER(), ABS(), and ROUND().
-- Scalar functions in SQL and programming generally, take one or more input values and return a single output value


-- 聚合函数
-- what is aggregate function?
-- An aggregate function is a function that operates on a set of values and returns a single value. It is used to perform calculations on multiple rows of data, such as SUM(), AVG(), COUNT(), MAX(), and MIN().
-- Aggregate functions are used to perform calculations on a set of values and return a single value. They are often used in conjunction with the GROUP BY clause to group rows that have the same values in specified columns into summary rows.

-- what is count(*) in SQL?
-- COUNT(*) is an aggregate function in SQL that returns the total number of rows in a result set, including rows with NULL values. 
-- It counts all rows regardless of whether they contain NULL values or not.
-- COUNT(*) is often used to determine the number of records in a table or the number of records that match a specific condition in a query.

-- =================== HOWTO ===================

-- How to use aggregate functions wihtout group by?
-- Aggregate functions can be used without a GROUP BY clause to perform calculations on the entire result set. 
-- In this case, the aggregate function will return a single value that represents the calculation for all rows in the result set.

-- For example, to get the total number of rows in a table, you can use the COUNT() function without a GROUP BY clause: 
SELECT COUNT(*) FROM table_name;

-- how is group by implemented in SQL?
-- ????


-- How does gorup by works:
-- SQL scans the table and groups rows based on the columns listed in the GROUP BY clause.
-- For each group, aggregate functions are calculated.
-- The result is one row per group.

-- how to group by multiple columns?
-- To group by multiple columns, you can list the columns in the GROUP BY clause separated by commas.
-- For example, to group by both "column1" and "column2", you would write:
SELECT column1, column2, COUNT(*)
FROM table_name
GROUP BY column1, column2;
-- This will group the rows by the unique combinations of values in "column1" and "column2", 
-- and return the count of rows for each combination.
