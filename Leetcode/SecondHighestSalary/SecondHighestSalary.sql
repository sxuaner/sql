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
