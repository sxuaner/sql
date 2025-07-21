-- what is keyword interval in sql?
-- The `INTERVAL` keyword in SQL is used to specify a time duration or a period of time. It is often used in date and time calculations, 
-- allowing you to add or subtract a specific amount of time from a date or timestamp. The syntax and usage can vary slightly between different SQL databases, 
-- but the general concept remains the same.


-- For example, in PostgreSQL, you can use the `INTERVAL` keyword to add or subtract time from a date:
SELECT CURRENT_DATE + INTERVAL '1 day';  -- Adds one day to the current date
SELECT CURRENT_TIMESTAMP - INTERVAL '2 hours';  -- Subtracts two hours from the current timestamp       
SELECT '2023-01-01'::date + INTERVAL '1 month';  -- Adds one month to a specific date


-- In MySQL, you can use the `INTERVAL` keyword in a similar way:
SELECT NOW() + INTERVAL 1 DAY;  -- Adds one day to the current timestamp
SELECT DATE_SUB(NOW(), INTERVAL 2 HOUR);  -- Subtracts two hours from the current timestamp
SELECT DATE_ADD('2023-01-01', INTERVAL 1 MONTH);  -- Adds one month to a specific date

-- In Oracle, the `INTERVAL` keyword is also used, but the syntax is slightly different:
SELECT SYSDATE + INTERVAL '1' DAY;  -- Adds one day to the current date             

-- In SQL Server, the `DATEADD` function is used instead of `INTERVAL`, but it serves a similar purpose:
SELECT DATEADD(DAY, 1, GETDATE());  -- Adds one day to the current date 
SELECT DATEADD(HOUR, -2, GETDATE());  -- Subtracts two hours from the current timestamp
SELECT DATEADD(MONTH, 1, '2023-01-01');  -- Adds one month to a specific date
-- The `INTERVAL` keyword is useful for performing date and time arithmetic, allowing you to manipulate dates and times easily in SQL queries.  

-- | Database    | INTERVAL Keyword | Alternative Function   | Example                          |
-- |-------------|------------------|-----------------------|----------------------------------|
-- | PostgreSQL  | Yes              | N/A                   | NOW() + INTERVAL '2 days'        |
-- | MySQL       | Yes              | N/A                   | NOW() + INTERVAL 2 DAY           |
-- | SQL Server  | No               | DATEADD               | DATEADD(day, 2, GETDATE())       |
-- | Oracle      | Yes              | N/A                   | SYSDATE + INTERVAL '2' DAY       |
-- | SQLite      | No               | Date/time modifiers   | DATE('now', '+2 days')           |