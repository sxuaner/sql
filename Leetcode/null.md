-- Differences between NULL and 'null' in SQL

-- 1. NULL is a special marker indicating absence of a value.
-- 2. 'null' (or "null") is a string literal containing the characters n-u-l-l.

-- Example:
SELECT
    NULL AS null_value,
    'null' AS string_null;

-- NULL handling in SQL

-- 1. COALESCE: Returns the first non-null value.
SELECT COALESCE(column1, 'default') FROM table;

-- 2. IS NULL / IS NOT NULL: Check for NULL values.
SELECT * FROM table WHERE column1 IS NULL;

-- 3. IFNULL: Returns a value if the expression is NULL (MySQL/SQLite).
SELECT IFNULL(column1, 'default') FROM table;

-- 4. CASE: Conditional handling of NULLs.
SELECT
    CASE
        WHEN column1 IS NULL THEN 'default'
        ELSE column1
    END
FROM table;

-- 5. NULLIF: Returns NULL if arguments are equal.
SELECT NULLIF(column1, column2) FROM table;

-- 6. Default values: Specify defaults to avoid NULLs.
CREATE TABLE example (
    id INT PRIMARY KEY,
    name VARCHAR(100) DEFAULT 'unknown'
);

-- 7. Data type considerations: Choose types that suit NULL handling.

-- 8. Filtering: Exclude NULLs in queries.
SELECT * FROM table WHERE column1 IS NOT NULL;

-- 9. Aggregate functions: COUNT, SUM, AVG ignore NULLs.
SELECT COUNT(column1), SUM(column1), AVG(column1) FROM table;

-- 10. Data integrity constraints: Use NOT NULL.
CREATE TABLE example2 (
    id INT PRIMARY KEY,
    value INT NOT NULL
);

-- 11. Join conditions: Be aware of NULLs in joins.

-- 12. String functions: Handle NULLs in string operations.
SELECT CONCAT(column1, 'suffix') FROM table;

-- 13. Documentation: Comment on NULL handling in schema.

-- 14. Testing: Test queries for NULL handling.

-- 15. Database-specific functions: Refer to your DBMS docs.

-- 16. Data cleaning: Regularly address NULLs in data.

-- 17. NULL in JSON: Understand how your DB handles JSON NULLs.

-- 18. Performance: Excessive NULLs may impact performance; consider indexing and optimization.

-- Oracle-specific notes:
-- - Oracle treats empty strings as NULL.
-- - Arithmetic with NULL yields NULL.
-- - Do not use NULL to represent zero.