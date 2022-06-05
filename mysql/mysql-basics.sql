

-- --------------------------------------- Database Setup and login --------------------------------------- 
-- to login using password with user name and host
-- mysql -h host -u user -p <optionally the db name>

-- logging out
-- quit

-- --------------------------------------- Data Types -- ---------------------------------------

-- --------------------------  Integer Types (Exact Value) --------------------------
-- Type		Storage (Bytes)	Minimum Value Signed	Minimum Value Unsigned	Maximum Value Signed	Maximum Value Unsigned
-- TINYINT		1			-128					0						127						255
-- SMALLINT		2			-32768					0						32767					65535
-- MEDIUMINT	3			-8388608				0						8388607					16777215
-- INT			4			-2147483648				0						2147483647				4294967295
-- BIGINT		8			-2^63					0						2^63-1(9223372036854775807)				2^64-1

-- --------------------------  Numeric type (Exact Value) --------------------------
-- what's in orcale db called number(precision, scale) is now in Mysql called decimal(precision, scale)

-- The precision represents the number of significant digits that are stored for values, and the scale represents the number 
-- of digits that can be stored following the decimal point.

-- Standard SQL requires that DECIMAL(5,2) be able to store any value with five digits and two decimals.
-- so values that can be stored in the salary column range from -999.99 to 999.99.

-- In standard SQL, the syntax DECIMAL(M) is equivalent to DECIMAL(M,0). Similarly, the syntax DECIMAL is equivalent to DECIMAL(M,0), 
-- where the implementation is permitted to decide the value of M. MySQL supports both of these variant forms of DECIMAL syntax. 
-- The default value of M is 10.
-- The maximum number of digits for DECIMAL is 65 ??? Why?

-- Type attritube:
-- All integer types can have an optional (nonstandard) UNSIGNED attribute.
-- An unsigned type can be used to permit only nonnegative numbers in a column or when you need a larger upper numeric range for the column.
-- For example, if an INT column is UNSIGNED, the size of the column's range is the same but its endpoints shift up, 
-- from -2147483648 and 2147483647 to 0 and 4294967295.

-- If you specify ZEROFILL for a numeric column, MySQL automatically adds the UNSIGNED attribute.

-- Integer data types can have the AUTO_INCREMENT attribute.
-- As of MySQL 8.0.17, AUTO_INCREMENT support is deprecated for FLOAT and DOUBLE columns; 
-- Consider removing the AUTO_INCREMENT attribute from such columns, or convert them to an integer type.

-- Storing NULL into an AUTO_INCREMENT column has the same effect as storing 0, unless the NO_AUTO_VALUE_ON_ZERO SQL mode is enabled.
-- Inserting NULL to generate AUTO_INCREMENT values requires that the column be declared NOT NULL.

 -- Negative values for AUTO_INCREMENT columns are not supported.




-- --------------------------  Floating-Point Types (Approximate numeric data values) --------------------------
-- MySQL uses four bytes for single-precision values and eight bytes for double-precision values.
-- what are these? 

-- Exponent meaning: a quantity representing the power to which a given number or expression is to be raise. 3 Raised to the power of 5: 3^5

-- For maximum portability, code requiring storage of approximate numeric data values should use FLOAT or DOUBLE PRECISION with no 
-- specification of precision or number of digits.

-- find out why FLOAT(M,D) will be removed 

-- As of MySQL 8.0.17, the UNSIGNED attribute is deprecated for columns of type FLOAT, DOUBLE, and DECIMAL (and any synonyms) 
-- and you should expect support for it to be removed in a future version of MySQL. Consider using a simple CHECK constraint???? instead for such columns.

-- --------------------------  Bit-Value Type - BIT  --------------------------
-- The BIT data type is used to store bit values. A type of BIT(M) enables storage of M-bit values. M can range from 1 to 64.
-- b'111' and b'10000000' represent 7 and 128,

-- If you assign a value to a BIT(M) column that is less than M bits long, the value is padded on the left with zeros. For example, 
-- assigning a value of b'101' to a BIT(6) column is, in effect, the same as assigning b'000101'.


-- --------------------------  Out-of-Range and Overflow Handling --------------------------
-- Link: https://dev.mysql.com/doc/refman/8.0/en/out-of-range-and-overflow.html

-- When MySQL stores a value in a numeric column that is outside the permissible range of the column data type, the result 
-- depends on the SQL mode in effect at the time:

-- If strict SQL mode is enabled, MySQL rejects the out-of-range value with an error, and the insert fails, in accordance with the SQL standard.

-- If no restrictive modes are enabled, MySQL clips the value to the appropriate endpoint of the column data type range and 
-- stores the resulting value instead.    

-- Clip meaning: to cut something with scissors or a similar sharp tool, especially to make it tidier:

-- When an out-of-range value is assigned to an integer column, MySQL stores the value representing the corresponding 
-- endpoint of the column data type range.
-- When a floating-point or fixed-point column is assigned a value that exceeds the range implied by the specified 
-- (or default) precision and scale, MySQL stores the value representing the corresponding endpoint of that range.

SET sql_mode = ''; -- '' means non-traditional mode
INSERT INTO t1 (i1, i2) VALUES(256, 256);
SHOW WARNINGS;
-- +---------+------+---------------------------------------------+
-- | Level   | Code | Message                                     |
-- +---------+------+---------------------------------------------+
-- | Warning | 1264 | Out of range value for column 'i1' at row 1 |
-- | Warning | 1264 | Out of range value for column 'i2' at row 1 |
-- +---------+------+---------------------------------------------+
SELECT * FROM t1;
-- +------+------+
-- | i1   | i2   |
-- +------+------+
-- |  127 |  255 |


-- Overflow during numeric expression evaluation results in an error.
SELECT 9223372036854775807 + 1;
-- ERROR 1690 (22003): BIGINT value is out of range in '(9223372036854775807 + 1)'
-- Solution 1: 
SELECT CAST(9223372036854775807 AS UNSIGNED) + 1;
-- +-------------------------------------------+
-- | CAST(9223372036854775807 AS UNSIGNED) + 1 |
-- +-------------------------------------------+
-- |                       9223372036854775808 |


-- DECIMAL values have a larger range than integers. Why is that?
-- Decimal has 65 digits which is max 2^64-1(twice the range of integer)
SELECT 9223372036854775807.0 + 1;
-- +---------------------------+
-- | 9223372036854775807.0 + 1 |
-- +---------------------------+
-- |     9223372036854775808.0 |


-- NO_UNSIGNED_SUBTRACTION mode: 
-- Subtraction between integer values, where one is of type UNSIGNED, produces an unsigned result by default. 
-- If the result would otherwise have been negative, an error results
SET sql_mode = '';
-- Query OK, 0 rows affected (0.00 sec)

SELECT CAST(0 AS UNSIGNED) - 1;  -- the result is expected to be unsigned by default.
-- ERROR 1690 (22003): BIGINT UNSIGNED value is out of range in '(cast(0 as unsigned) - 1)'

-- If the NO_UNSIGNED_SUBTRACTION SQL mode is enabled, the result is negative:
SET sql_mode = 'NO_UNSIGNED_SUBTRACTION';
SELECT CAST(0 AS UNSIGNED) - 1;
-- +-------------------------+
-- | CAST(0 AS UNSIGNED) - 1 |
-- +-------------------------+
-- |                      -1 |

-- --------------------------  Date and Time Data Types--------------------------
-- The date and time data types for representing temporal values are DATE, TIME, DATETIME, TIMESTAMP, and YEAR. 
-- Each temporal type has a range of valid values, as well as a “zero” value that may be used when you specify 
-- an invalid value that MySQL cannot represent.

-- The TIMESTAMP and DATETIME types have special automatic updating behavior,

-- date parts must always be given in year-month-day order (for example, '98-09-04'), !!! single quote is used
-- To convert strings in other orders to year-month-day order, the STR_TO_DATE() function may be useful.

-- Converting between temporal values: https://dev.mysql.com/doc/refman/8.0/en/date-and-time-type-conversion.html

-- MySQL automatically converts a date or time value to a number if the value is used in numeric context and vice versa.

-- By default, when MySQL encounters a value for a date or time type that is out of range or otherwise invalid for the type, 
-- it converts the value to the “zero” value for that type. The exception is that out-of-range TIME values are clipped to
-- the appropriate endpoint of the TIME range. 

-- MySQL permits you to store dates where the day or month and day are zero in a DATE or DATETIME column. This is useful 
-- for applications that need to store birthdates for which you may not know the exact date. In this case, you simply 
-- store the date as '2009-00-00' or '2009-01-00'.
-- To disallow zero month or day parts in dates, enable the NO_ZERO_IN_DATE mode.

-- MySQL permits you to store a “zero” value of '0000-00-00' as a “dummy date.” In some cases, this is more convenient 
-- than using NULL values, and uses less data and index space. To disallow '0000-00-00', enable the NO_ZERO_DATE mode.

-- “Zero” date or time values used through Connector/ODBC are converted automatically to NULL because ODBC cannot handle such values.

-- "Zero" Values:
-- Data Type	“Zero” Value
-- DATE			'0000-00-00'
-- TIME			'00:00:00'
-- DATETIME		'0000-00-00 00:00:00'
-- TIMESTAMP	'0000-00-00 00:00:00'
-- YEAR			0000

-- --- Fractional seconds in datetype
-- MySQL permits fractional seconds for TIME, DATETIME, and TIMESTAMP values, with up to microseconds (6 digits) precision
-- To define a column that includes a fractional seconds part, use the syntax type_name(fsp), where type_name is TIME, DATETIME,
--  or TIMESTAMP, and fsp is the fractional seconds precision. For example:

-- -- Date:
-- MySQL displays DATE values in 'YYYY-MM-DD' format, but permits assignment of values to DATE columns using either strings or numbers.

-- Automatic initialization and updating to the current date and time for DATETIME columns can be specified using DEFAULT and 
-- ON UPDATE column definition clauses, 


-- Date and time literals
-- In computer science, a literal is a notation for representing a fixed value in source code.
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-literals.html

-- Definition of ODBC : 
-- Open Database Connectivity (ODBC) is an open standard Application Programming Interface (API) for accessing a database. 

-- Standard SQL and ODBC Date and Time Literals.  Standard SQL requires temporal literals to be specified using a type keyword 
-- and a string. The space between the keyword and string is optional.
-- DATE 'str'			TIME 'str'		 TIMESTAMP 'str'

-- MySQL recognizes but, unlike standard SQL, does not require the type keyword. Applications that are to be standard-compliant 
-- should include the type keyword for temporal literals

-- How to use TIMESTAMP?

--  --- Deprecation 
-- MySQL 8.0 does not support the 2-digit YEAR(2) data type permitted in older versions of MySQL.
-- As of MySQL 8.0.19, the YEAR(4) data type with an explicit display width is deprecated; you should expect support for it to
-- be removed in a future version of MySQL. Instead, use YEAR without a display width, which has the same meaning.

-- The SUM() and AVG() aggregate functions do not work with temporal values. (They convert the values to numbers, losing everything 
-- after the first nonnumeric character.) To work around this problem, convert to numeric units, perform the aggregate operation, and 
-- convert back to a temporal value. Examples:
SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(time_col))) FROM tbl_name;
SELECT FROM_DAYS(SUM(TO_DAYS(date_col))) FROM tbl_name;

-- how to show time based on time zone interval
SELECT col, CAST(col AT TIME ZONE INTERVAL '+00:00' AS DATETIME) AS ut FROM ts ORDER BY id;

-- -----------------------------------  Date type spec -------------------------------
-- MySQL retrieves and displays TIME values in 'hh:mm:ss' format (or 'hhh:mm:ss' format for large hours values). 
-- TIME values may range from '-838:59:59' to '838:59:59'
-- MySQL interprets abbreviated TIME values with colons as time of the day. That is, '11:12' means '11:12:00', 
-- not '00:11:12'.

-- MySQL interprets abbreviated values without colons using the assumption that the two rightmost digits represent 
-- seconds (that is, as elapsed time rather than as time of day). 
-- MySQL interprets 1112 as '00:11:12'. Similarly, '12' and 12 are interpreted as '00:00:12'.

-- The only delimiter recognized between a time part and a fractional seconds part is the decimal point.

-- By default, values that lie outside the TIME range but are otherwise valid are clipped to the closest endpoint 
-- of the range.

-- -----------------------  THe year type ------------------------------
-- The YEAR type is a 1-byte type used to represent year values. 
-- It can be declared as YEAR with an implicit display width of 4 characters,
-- YEAR(4) is deprecated

-- YEAR accepts input values in a variety of formats:
-- As 4-digit strings in the range '1901' to '2155'.
-- As 4-digit numbers in the range 1901 to 2155.
-- As 1- or 2-digit strings in the range '0' to '99'. MySQL converts values in the ranges 
-- '0' to '69' and '70' to '99' to YEAR values in the ranges 2000 to 2069 and 1970 to 1999.
-- As 1- or 2-digit numbers in the range 0 to 99. MySQL converts values in the ranges 1 to 
-- 69 and 70 to 99 to YEAR values in the ranges 2001 to 2069 and 1970 to 1999.
-- The result of inserting a numeric 0 has a display value of 0000 and an internal value of 0000. 
-- To insert zero and have it be interpreted as 2000, specify it as a string '0' or '00'.
-- As the result of functions that return a value that is acceptable in YEAR context, such as NOW().


-- ------------------ TIMESTAMP and DATETIME -------------------
-- TIMESTAMP and DATETIME columns can be automatically initializated and updated to the current date 
-- and time (that is, the current timestamp).

-- An auto-initialized column is set to the current timestamp for inserted rows that specify no value 
-- for the column.

-- An auto-updated column is automatically updated to the current timestamp when the value of any other 
-- column in the row is changed from its current value.(When a column other than this column of TIMESTAMP
-- type is changed, the TIMESTAMP column will be updated to the current.

-- A method to update TIMESTAMP:
-- if the explicit_defaults_for_timestamp system variable is disabled, you can initialize or update any 
-- TIMESTAMP (but not DATETIME) column to the current date and time by assigning it a NULL value, unless 
-- it has been defined with the NULL attribute to permit NULL values.

-- Use of DEFAULT CURRENT_TIMESTAMP and ON UPDATE CURRENT_TIMESTAMP is specific to TIMESTAMP and DATETIME.
CREATE TABLE t1 (
  ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  dt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- DATETIME has a default of NULL unless defined with the NOT NULL attribute, in which case the default is 0.

-- TIMESTAMP initialization and the NULL attribute

-- If the explicit_defaults_for_timestamp system variable is disabled, TIMESTAMP columns by default are NOT NULL, 
-- cannot contain NULL values, and assigning NULL assigns the current timestamp. 

-- To permit a TIMESTAMP column to contain NULL, explicitly declare it with the NULL attribute. In this case, 
-- the default value also becomes NULL 
-- unless overridden with a DEFAULT clause that specifies a different default value. DEFAULT NULL can be used to 
-- explicitly specify NULL as the default value. (For a TIMESTAMP column not declared with the NULL attribute, 
-- DEFAULT NULL is invalid.) If a TIMESTAMP column permits NULL values, assigning NULL sets it to NULL, not to the 
-- current timestamp.


CREATE TABLE t3 (
  ts1 TIMESTAMP NULL DEFAULT 0,			-- define a column with name ts1 of type TIMESTAMP. 
										-- Due tu NULL attribute, The values can be NULL
										-- The default value is 0
										-- However, if there was no 'DEFAULT 0', the default value would be NULL
  ts2 TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                ON UPDATE CURRENT_TIMESTAMP);


-- ------------------------  Time zone --------------------------- 
-- The session time zone setting affects display and storage of time values that are zone-sensitive. 
-- This includes the values displayed by functions such as NOW() or CURTIME(), and values stored in and retrieved 
-- from TIMESTAMP columns. Values for TIMESTAMP columns are converted from the session time zone to UTC for 
-- storage, and from UTC to the session time zone for retrieval.

-- The session time zone setting does not affect values displayed by functions such as UTC_TIMESTAMP() or values in 
-- DATE, TIME, or DATETIME columns. Nor are values in those data types stored in UTC; the time zone applies for 
-- them only when converting from TIMESTAMP values. If you want locale-specific arithmetic for DATE, TIME, or 
-- DATETIME values, convert them to UTC, perform the arithmetic, and then convert back.

-- Several tables in the mysql system schema exist to store time zone information (see Section 5.3, “The mysql 
-- System Schema”). The MySQL installation procedure creates the time zone tables, but does not load them. To do 
-- so manually, use the following instructions.

-- --------------------------  Functions and Operators -------------------------- 
--  Cast
-- BINARY operator is deprecated. Use CAST(... AS BINARY) instead

-- ---------------------------------------Concepts --------------------------------------- 
--  mysql accepts free-format input: it collects input lines but does not execute them until it sees the semicolon.

-- If you decide you do not want to execute a command that you are in the process of entering, cancel it by typing \c:
-- mysql> SELECT
--    -> USER()
--    -> \c

-- The '> and "> prompts occur during string collection (another way of saying that MySQL is waiting for completion of a string).
-- When you see a '> or "> prompt, it means that you have entered a line containing a string that begins with a “'” or “"” quote character, 
-- but have not yet entered the matching quote that terminates the string


-- Fixed value is preferred
-- How about age? That might be of interest, but it is not a good thing to store in a database. Age changes as time passes, which means 
-- you'd have to update your records often. 
-- Instead, it is better to store a fixed value such as date of birth. Then, whenever you need age, you can calculate 
-- it as the difference between the current date and 
-- the birth date. MySQL provides functions for doing date arithmetic, so this is not difficult. Storing birth date rather than age has other advantages.

-- Unsigned keyword
CREATE TABLE t1 (i1 TINYINT, i2 TINYINT UNSIGNED);

-- Cast a signed value to unsigned value:
SELECT CAST(9223372036854775807 AS UNSIGNED) + 1;

-- Transactional table???

-- --------------------------------------- DB management---------------------------------------
-- How to create a database?
CREATE DATABASE toys;

-- To get the version of this mysql instance
SELECT Version();



-- To set time zone globally:
SET GLOBAL time_zone = timezone;

-- To set time zone per session
SET time_zone = timezone;

-- To retrieve session time zone and global time zone:
SELECT @@GLOBAL.time_zone, @@SESSION.time_zone;
-- returns SYSTEM meaning that the server time zone is the same as the system time zone.
-- Possible results: 
-- System
-- As a string indicating an offset from UTC of the form [H]H:MM, prefixed with a + or -
-- As a named time zone, such as 'Europe/Helsinki', 'US/Eastern', 'MET', or 'UTC'.

-- @@ - System Vaiable
-- @@ is used for system variables. Using different suffix with @@, you can get either session 
-- or global value of the system variable.

-- When you refer to a system variable in an expression as @@var_name (that is, when you do not 
-- specify @@global. or @@session.), MySQL returns the session value if it exists and the global 
-- value otherwise. (This differs from SET @@var_name = value, which always refers to the session value.)

-- @ - User Defined Variable
-- while @ is used for user defined variables.



-- To get current version of this mysql instance
SHOW VARIABLES LIKE "%version%";
-- OR
SELECT VERSION(), CURRENT_DATE;

-- To get current datetime to the granularity of second: 2021-09-07 10:18:44
SELECT NOW();

-- To get user information: root@localhost
SELECT USER();

-- show all dbs
-- SHOW DATABASES does not show databases that you have no privileges for if you do not have the SHOW DATABASES privilege. See privilege part
SHOW DATABASES;

-- You can see at any time which database is currently selected( by me?) using 
SELECT DATABASE();

-- Login does not in itself select any database to work with. Select hibernate db. Under Unix, database names are case sensitive 
-- you must select the database for use each time you begin a mysql session.
USE HIBERNATE;

-- List all tables in this database
SHOW TABLES;

-- show system variable sql mode: 
SELECT  @sql_mode;  -- return null
SELECT @@SESSION.sql_mode;
SELECT @@sql_mode; 
-- Previous line of sql returns:
-- ONLY_FULL_GROUP_BY,
-- STRICT_TRANS_TABLES,
-- NO_ZERO_IN_DATE,
-- NO_ZERO_DATE,
-- ERROR_FOR_DIVISION_BY_ZERO,
-- NO_ENGINE_SUBSTITUTION

-- About sql modes
-- When this manual refers to “strict mode,” it means a mode with either or both STRICT_TRANS_TABLES or STRICT_ALL_TABLES enabled.
-- Get a full list of sql modes here: https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html

-- Setting the GLOBAL variable requires the SYSTEM_VARIABLES_ADMIN privilege (or the deprecated SUPER privilege)
-- Each client can change its session sql_mode value at any time.
SET GLOBAL sql_mode = 'modes';
SET SESSION sql_mode = 'modes'; 

SHOW WARNINGS;

-- --------------------------------------- Privileges ---------------------------------------
-- Granting all privileges to a user
GRANT ALL ON menagerie.* TO 'your_mysql_name'@'your_client_host';



-- --------------------------------------- Data Definition Language: DDL ---------------------------------------
-- drop the table. Wrong syntax: drop table toys if exists;
DROP TABLE IF EXISTS toys;

-- Int(width) has been deprecated
CREATE TABLE toys(
 ID 	INT
);


-- --------------------------------------- Padding?---------------------------------------
-- Applications can use the LPAD() function to zero-pad numbers up to the desired width, or they can store the 
-- formatted numbers in CHAR columns.


