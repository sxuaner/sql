------------ ------------ ------------ ------------ ------------  Design principles: The Principle of Least Privilege. ------------ ------------ ------------ ------------ 
-- A good coding habbit is the key to success. Use uppercase for sql keywords and lowercase for vars and user defined names
-- The Principle of Least Privilege.


------------ ------------ ------------ ------------ ------------  Knowledge ------------ ------------ ------------ ------------ ------------ 
-- Regarding tablespace
--Each database can have many Schema/User (Logical division).
--Each database can have many tablespaces (Logical division).
--A schema is the set of objects (tables, indexes, views, etc) that belong to a user.
--In Oracle, a user can be considered the same as a schema.
--A database is divided into logical storage units called tablespaces, which group related logical structures together. For example, tablespaces commonly group all of an application’s objects to simplify some administrative operations. You may have a tablespace for application data and an additional one for application indexes.

-- https://docs.oracle.com/cd/B19306_01/network.102/b14266/admusers.htm#i1006219
-- https://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_4003.htm#SQLRF01103

-- ALTER USER: 
-- https://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_4003.htm#SQLRF01103

-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_7003.htm#CJAEADCI    here to read the diagram

------------ ------------ ------------ ------------ ------------  Administrative Tasks ------------ ------------ ------------ ------------ ------------ ------------ 
-- describe the table
DESC dba_users;

-- droep use and all its objects
DROP USER sx CASCADE;
-- To test connection with username ans pwd:
CONN sx/songxuan

CONN sys/songxuan as SYSDBA;
-- 
SELECT USERNAME, default_tablespace from dba_users where username='SX';

-- disply info of dba_users;
SELECT username, expiry_date， account_status，lock_date, password_versions FROM dba_users ORDER BY username;

-- Try to unlock hr account, which in fact does not exist in the db. Returns error
-- ACCOUNT UNLOCK comes after IDENTIFEID BY
ALTER USER aurora IDENTIFIED BY songxuan ACCOUNT UNLOCK;
ALTER USER sys IDENTIFIED BY songxuan; 

-- check current user's privileges
SELECT * FROM USER_SYS_PRIVS; 

CONN sys/songxuan as sysdba;
ALTER USER hr IDENTIFIED BY Password ACCOUNT UNLOCK ;

--------------------------  User management ---------------------------
-- create user sx
CREATE USER sx IDENTIFIED BY songxuan;

-- Grant CONNECT Role to sx
-- However, beginning in Oracle Database 10g Release 2 (10.2), the CONNECT role has only the CREATE SESSION privilege, all other privileges are removed.
GRANT CONNECT TO sx;

-- Grant create table to  sx
GRANT CREATE TABLE TO sx;

-- to allow create normal user like "sx" instead of having to start with "C##"
ALTER SESSION SET "_ORACLE_SCRIPT"=true;


--------------------------  Data creation ---------------------------
-- create a table, "insufficient privileges" for sx. User must have "CREATE TABLE" privilege.
-- Datatypes?
CREATE TABLE SampleTable(
    Name varchar(255),
    ID int
);

-- drop a table
DROP TABLE Sampletable;

-- Is it possible to modify datatypes in the table columns?
-- Alter ID column and make it primary key by adding.
ALTER TABLE SampleTable
  ADD (
    CONSTRAINT ID_PK PRIMARY KEY (id)
  );
  
-- Remove primary key named ID
ALTER TABLE SampleTable DROP CONSTRAINT ID;

-- Insert test data
--INSERT INTO table_name (column1, column2, column3, ...)  VALUES (value1, value2, value3, ...);
-- Return error:  no privileges on tablespace 'USERS'
INSERT INTO sampletable (NAME,ID) VALUES('sx', 1);
INSERT INTO sampletable (NAME,ID) VALUES('A', 2);
INSERT INTO sampletable (NAME,ID) VALUES('B', 3);

-- how to manage tablespace?
-- What is tablespace in Oracle
-- An Oracle database consists of one or more logical storage units called tablespaces, which collectively store all of the database's data. 
-- Each tablespace in an Oracle database consists of one or more files called datafiles, which are physical structures that conform to the operating system in which Oracle is running.

-- Sample table
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255) 
);

-- To create tablespace, CREATE TABLESPACE privilege must be granted
-- grant create table privilege, use CONN to grant as sysdba.
CONN sys/songxuan as SYSDBA;
GRANT CREATE TABLESPACE TO sx;

-- creation

CONN sys/songxuan as SYSDBA;
-- TO create a tablespace with SMALLFILE option and name 'learning' for 100MB
CREATE SMALLFILE TABLESPACE Learning DATAFILE 'learning' SIZE 100M ONLINE;

-- Assigning a Default Tablespace

CONN sys/songxuan as SYSDBA;
ALTER USER sx DEFAULT TABLESPACE learning;

-- Grant Quota to sx on learning tablespace
CONN sys/songxuan as SYSDBA;
ALTER USER sx QUOTA 100M ON learning;

SELECT USERNAME, default_tablespace FROM dba_users WHERE username='SX';

-- Altering and Maintaining Tablespaces
-- https://docs.oracle.com/cd/B28359_01/server.111/b28310/tspaces007.htm#ADMIN11362

-------------------------- Oracle database 2d Developer's Guide 11g release practices---------------------------
-- Use column name alias, which is used after column name
SELECT Name "Name Of Candidates", ID "ID Number" FROM sampletable;

-- Use table aliases which are created in FROM claus.  Table alias is usually used when there are coloumns from 2 tables with same names. It's used to avoid name conflict.
SELECT sam.id FROM sampletable sam;

-- Comparison Operator = 
SELECT * FROM sampletable WHERE ID=1;

-- !=, <>, >, >=, <, <=, BETWEEN .. AND .., LIKE, IN(), NOT IN(), IS NULL, IS NOT NULL
SELECT * FROM sampletable WHERE ID!=1;
SELECT * FROM sampletable WHERE ID<>1;
-- BETWEEN .. IN .. Test for a fit in the range between 2 values, inclusive
SELECT * FROM sampletable WHERE ID BETWEEN 1 AND 3;

-- % wildcard symbol for zero or multiple chars
-- _ underscore for a single char.
SELECT * FROM sampletable WHERE name LIKE '%A_';            -- NONE
SELECT * FROM sampletable WHERE name LIKE 'A';              -- FOUND
SELECT * FROM sampletable WHERE name LIKE 'A%';              -- FOUND
SELECT * FROM sampletable WHERE name LIKE '%A_';              -- NONE

-- Pay attention to case here, doulbe quote is not allowed with LIKE. The meaning of Like operator is: test for a matching string 
SELECT * FROM sampletable WHERE name LIKE 'SX';              -- NONE
SELECT * FROM sampletable WHERE name LIKE 'Sx';              -- NONE
SELECT * FROM sampletable WHERE name LIKE 'sx';              -- Found

-- IN(), test for a match in a specified list of values
SELECT * FROM sampletable WHERE ID IN (1,2,3);      
-- NOT IN()
SELECT * FROM sampletable WHERE ID NOT IN (1,2);      
-- IS NOT NULL
SELECT * FROM sampletable WHERE NAME IS NOT NULL;


--- Regular expression:


-- flush privileges:
