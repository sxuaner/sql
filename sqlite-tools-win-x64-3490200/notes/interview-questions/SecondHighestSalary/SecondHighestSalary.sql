-- select distinct salary As SecondHighestSalary 
--     from employee 
--     where salary is not null
--     order by salary desc limit 1,1;

-- Solution 1:
-- Positive case
    select coalesce((
        select distinct salary As SecondHighestSalary 
            from employee 
            where salary is not null
            order by salary desc limit 1,1), 
            null) AS SecondHighestSalary;  -- it needs to return null instead of 'null' string

-- Negative case          
     select coalesce((
        select distinct salary As SecondHighestSalary 
            from employee 
            where salary is not null
            order by salary desc limit 7,1), 
            null) AS SecondHighestSalary;  -- it needs to return null instead of 'null' string


-- Solution 2            
select case 
    when (select count(distinct salary) from employee) < 2  then null       -- it needs to return null instead of 'null' string
    else (select distinct salary As SecondHighestSalary 
            from employee 
            where salary is not null
            order by salary desc limit 1,1) 
    end AS SecondHighestSalary;



-- Solution 3
SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary


-- what is coalesce?
-- COALESCE is a SQL function that returns the first non-null value in a list of arguments.
-- It is often used to provide a default value when dealing with NULLs. 
-- In the context of the query, it ensures that if there is no second highest salary, it returns 'null' instead of an empty result set.
-- COALESCE can take multiple arguments, and it will return the first one that is not NULL. 


-- how to rename the column in the result set?
-- To rename a column in the result set, you can use the `AS` keyword followed by the new name for the column.


-- Wrong answer analysis:
-- 输出
-- | SecondHighestSalary |
-- | ------------------- |
-- | "200"               |
-- 预期结果
-- | SecondHighestSalary |
-- | ------------------- |
-- | 200                 |
    select coalesce((
        select distinct salary As SecondHighestSalary 
            from employee 
            where salary is not null
            order by salary desc limit 1,1), 
            "null") AS SecondHighestSalary;  -- it needs to return null instead of 'null' string

what are the differences between  null and "null" in SQL?
-- In SQL, `null` and `"null"` are treated differently:
-- 1. `null` is a special marker used to indicate that a data value does not exist in the database.
-- 2. `"null"` is a string literal that contains the characters 'n', 'u', 'l', 'l'. It is not treated as a null value but as a regular string.  

-- A field with a NULL value is a field with no value. 
-- If a field in a table is optional, it is possible to insert a new record or update a record without adding a value to this field. 
-- Then, the field will be saved with a NULL value.

-- It is not possible to test for NULL values with comparison operators, such as =, <, or <>.
-- We will have to use the IS NULL and IS NOT NULL operators instead.


-- Nulls in Oracle Database  https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/Nulls.html
-- If a column in a row has no value, then the column is said to be null, or to contain null. Nulls can appear in 
-- columns of any data type that are not restricted by NOT NULL or PRIMARY KEY integrity constraints. Use a null 
-- when the actual value is not known or when a value would not be meaningful.

-- Oracle Database treats a character value with a length of zero as null. However, do not use null to represent a numeric value of zero, because they are not equivalent.

-- Note:Oracle Database currently treats a character value with a length of zero as null. However, this may not continue to be true in future releases, and Oracle recommends that you do not treat empty strings the same as nulls.
-- Any arithmetic expression containing a null always evaluates to null. For example, null added to 10 is null. In fact, all operators (except concatenation) return null when given a null operand.


-- How to handle NULL values in SQL?
-- Handling NULL values in SQL can be done using several techniques:
-- 1. **COALESCE**: This function returns the first non-null value in a list of arguments. It is useful for providing default values.
-- 2. **IS NULL / IS NOT NULL**: These operators are used to check for NULL values in conditions.
-- 3. **IFNULL**: This function returns a specified value if the expression is NULL, otherwise it returns the expression itself.
-- 4. **CASE**: This statement can be used to handle NULL values by providing different outcomes based on whether a value is NULL or not.
-- 5. **NULLIF**: This function returns NULL if the two arguments are equal; otherwise, it returns the first argument. It can be used to avoid division 
-- by zero or other similar issues.
-- 6. **Default Values**: When creating tables, you can specify default values for columns to avoid NULLs.
-- 7. **Data Type Considerations**: Some data types can handle NULL values better than others, so choosing the right data type can help in managing NULLs effectively.
-- 8. **Filtering**: Use WHERE clauses to filter out NULL values when querying data.
-- 9. **Aggregate Functions**: Functions like COUNT, SUM, AVG, etc., can handle NULL values in specific ways, so understanding their behavior is important.
-- 10. **Data Integrity Constraints**: Use NOT NULL constraints to ensure that certain columns cannot have NULL values when inserting or updating records.
-- 11. **Join Conditions**: Be cautious when joining tables, as NULL values can affect the results of joins. Use appropriate join types (INNER, LEFT, RIGHT) based on your needs.
-- 12. **String Functions**: When dealing with string data, functions like TRIM, CONCAT, and others can help manage NULL values effectively.
-- 13. **Documentation and Comments**: Documenting how NULL values are handled in your database schema can help maintain clarity for future developers.
-- 14. **Testing**: Always test your queries and logic to ensure that NULL values are handled as expected, especially in complex queries or when dealing with multiple tables.
-- 15. **Database-Specific Functions**: Different databases may have specific functions or features for handling NULL values, so refer to the documentation for your 
-- specific database system.
-- 16. **Data Cleaning**: Regularly clean your data to handle NULL values appropriately, especially in large datasets where NULLs may affect analysis or reporting.
-- 17. **Use of NULL in JSON**: If your database supports JSON data types, be aware of how NULL values are represented and handled within JSON structures.
-- 18. **Performance Considerations**: Be aware that excessive NULL values can impact query performance, so consider indexing strategies and query optimization techniques
-- to mitigate this.