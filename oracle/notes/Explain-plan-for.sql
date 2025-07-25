

-- In SQL, especially with databases like Oracle, EXPLAIN PLAN is a tool used to display the execution plan that the database optimizer chooses for a SQL query. 
-- This plan shows how the database will retrieve the requested data, including the order of operations, access paths, and join methods.

-- Why use EXPLAIN PLAN?
-- Performance Tuning: It helps you understand how your query will be executed, so you can optimize it for better performance.
-- Troubleshooting: If a query is slow, EXPLAIN PLAN can show if it's using inefficient operations (like full table scans instead of indexes).
-- How does it work?
-- You run:

EXPLAIN PLAN FOR
SELECT * FROM employees WHERE department_id = 10;

-- This stores the plan in a special table (often called PLAN_TABLE). You then query that table to see the plan:
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- What does the output show?
-- Operation: The type of step (e.g., TABLE ACCESS, INDEX SCAN, JOIN).
-- Object Name: The table or index involved.
-- Cost: An estimate of the resources needed.
-- Rows: Estimated number of rows processed at each step.
-- Gotchas
-- EXPLAIN PLAN shows the estimated plan, not always the actual plan used at runtime.
-- For actual runtime details, use tools like AUTOTRACE or query execution statistics.
-- Let me know if you want to see a specific example or how to interpret a particular plan!


-- DBMS_XPLAN.DISPLAY_CURSOR function: This function displays the actual execution plan of a query that has already been executed and is still in the shared pool. 
-- It provides more accurate information as it reflects runtime statistics. 
-- You'll typically need the SQL ID and child number, which can be found in V$SQL.

    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR('sql_id', child_number, 'ALLSTATS LAST'));

-- GATHER_PLAN_STATISTICS hint: This hint can be added to your SQL statement to instruct Oracle to collect and store actual execution plan statistics during query execution, 
-- which can then be viewed with DBMS_XPLAN.DISPLAY_CURSOR.
    SELECT /*+ GATHER_PLAN_STATISTICS */ e.last_name, d.department_name
    FROM employees e, departments d
    WHERE e.department_id = d.department_id;

--     2. Reading the Execution Plan:
-- Tree Structure:
-- Execution plans are presented in a tree-like structure. The indentation indicates parent-child relationships, with operations indented to the right being children of 
-- the less-indented operation above them.
-- Bottom-Up Flow:
-- Data generally flows from the "leaves" (table access operations like full table scans or index scans) upwards to the "root" (the final SELECT operation).
-- Key Information:
-- Look for:
-- Operations: (e.g., TABLE ACCESS FULL, INDEX UNIQUE SCAN, HASH JOIN, SORT GROUP BY).
-- Cost: Estimated resource consumption for each step.
-- Cardinality: Estimated number of rows processed by each step.
-- Predicate Information: Filtering conditions applied at each step.
-- Notes: Important details about optimizer decisions, such as adaptive plan usage.
-- By analyzing these elements, you can understand the sequence of operations Oracle performs, identify potential bottlenecks, and optimize your queries for better performance.