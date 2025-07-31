-- what is coalesce?
-- COALESCE is a SQL function that returns the first non-null value in a list of arguments.
-- It is often used to provide a default value when dealing with NULLs. 
-- In the context of the query, it ensures that if there is no second highest salary, it returns 'null' instead of an empty result set.
-- COALESCE can take multiple arguments, and it will return the first one that is not NULL. 



-- Example 1:
    select coalesce((
        select distinct salary As SecondHighestSalary 
            from employee 
            where salary is not null
            order by salary desc limit 1,1), 
            null) AS SecondHighestSalary;  -- it needs to return null instead of 'null' string



-- 1. COALESCE: Returns the first non-null value.
SELECT COALESCE(column1, 'default') FROM table;