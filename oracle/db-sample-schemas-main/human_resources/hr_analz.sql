Rem
Rem $Header: hr_analz.sql 12-oct-2002.10:24:59 ahunold Exp $
Rem
Rem hr_analz.sql
Rem
Rem Copyright (c) 2001, 2015, Oracle Corporation.  All rights reserved.  
Rem 
Rem Permission is hereby granted, free of charge, to any person obtaining
Rem a copy of this software and associated documentation files (the
Rem "Software"), to deal in the Software without restriction, including
Rem without limitation the rights to use, copy, modify, merge, publish,
Rem distribute, sublicense, and/or sell copies of the Software, and to
Rem permit persons to whom the Software is furnished to do so, subject to
Rem the following conditions:
Rem 
Rem The above copyright notice and this permission notice shall be
Rem included in all copies or substantial portions of the Software.
Rem 
Rem THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
Rem EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
Rem MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
Rem NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
Rem LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
Rem OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
Rem WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Rem
Rem    NAME
Rem      hr_analz.sql - Gathering statistics for HR schema
Rem
Rem    DESCRIPTION
Rem      Staistics are used by the cost based optimizer to
Rem      choose the best physical access strategy
Rem
Rem    NOTES
Rem      Results can be viewed in columns of DBA_TABLES, 
Rem      DBA_TAB_COLUMNS and such

-- Setting feedback to zero is equivalent to turning it OFF. SET FEEDBACK OFF also turns off the statement confirmation messages such as 'Table created' and 'PL/SQL 
-- procedure successfully completed' that are displayed after successful SQL or PL/SQL statements.
SET FEEDBACK 1

SET NUMWIDTH 10

-- If you are selecting data from a table with hundreds of lines, it will scroll quickly up the screen until the end of the data. 
-- If your page size isn't set, this will prevent you from being able to read all of it.
SET PAGESIZE 100
SET LINESIZE 80

-- SET TRIMSPOOL ON will remove blank space from the end of a line. 
--  What does the English word spool mean ?
--  The word spool is a contraction of the words "simultaneous" and "polling".

SET TRIMSPOOL ON
SET TAB OFF
SET ECHO OFF

-- With the DBMS_STATS package you can view and modify optimizer statistics gathered for database objects.
-- GATHER_SCHEMA_STATS Procedures

-- what are below parameters?
-- ownname      Name of the schema to analyze
-- granularity  Specifies the level of detail for the statistics
-- cascade      Specifies whether to gather statistics for dependent objects

EXECUTE dbms_stats.gather_schema_stats( -
        'HR'                            ,       -
        granularity => 'ALL'            ,       -
        cascade => TRUE                 ,       -
        block_sample => TRUE            );


Gathering schema statistics in a database, such as with Oracle's DBMS_STATS, is crucial for optimizing query performance. It provides the query 
optimizer with information about the data distribution, allowing it to choose the most efficient execution plan. Without accurate statistics, the 
optimizer may make poor choices, leading to slow query performance.

Here's a more detailed breakdown:

Why gather statistics?

Cost-based optimization:
Oracle's query optimizer uses statistics to estimate the cost of different execution plans and select the least expensive one. 

Accurate data representation:
Statistics represent the current state of the data, including the number of rows, data distribution, and index characteristics. 

Improved query performance:
By providing the optimizer with accurate information, statistics help it make better decisions, leading to faster query execution. 

Avoiding performance degradation:
As data in the database changes, statistics can become stale, leading to performance issues. Regularly gathering statistics ensures that the optimizer has the most up-to-date information. 

When to gather statistics:

After significant data changes:
When a large amount of data is loaded, updated, or deleted, the existing statistics may become inaccurate.

After schema changes:
Modifications to the database schema, such as adding or dropping columns, can also necessitate statistics gathering.

Regularly:
/account for : to explain the reason for something or the cause of something:/
Even without major data changes, it's good practice to gather statistics periodically to account for ongoing data modifications.

When performance degrades:
If users report slow query performance, gathering statistics may help identify and resolve the issue. 
In essence, gathering schema statistics is a proactive approach to maintaining database health and ensuring optimal query performance. 