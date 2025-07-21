-- The `RANK()` function in SQL is used to assign a unique rank to each row within a partition of a result set.
-- The rank is assigned based on the order specified in the `ORDER BY` clause. If two or more rows have the same values, they receive the same rank, 
-- and the next rank(s) are skipped.
-- The `RANK()` function is often used in conjunction with the `OVER()` clause to define the partitioning and ordering of the result set.
-- The syntax for using the `RANK()` function is as follows:    


SELECT
    column1,
    column2,
    RANK() OVER (PARTITION BY partition_column ORDER BY order_column DESC) AS rank
FROM
    table_name;


    select rank() over (partition by gender order by salary desc) AS RANK from  employee ;

    -- is RANK() scalar or aggregate?
-- The `RANK()` function is a window function, not an aggregate function.


