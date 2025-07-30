-- The SQL CASE Expression
-- The CASE expression goes through conditions and returns a value when the first condition is met (like an if-then-else statement).
-- So, once a condition is true, it will stop reading and return the result. If no conditions are true, it returns the value in the ELSE clause.
-- If there is no ELSE part and no conditions are true, it returns NULL.

-- CASE Syntax
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result  -- default (optional)
END;

-- 选2个字段，再加上comments
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;·