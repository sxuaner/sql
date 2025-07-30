-- rem Header: hr_main.sql 2015/03/19 10:23:26 smtaylor Exp $
-- rem
-- rem Owner  : ahunold
-- rem
-- rem NAME
-- rem   hr_main.sql - Main script for HR schema
-- rem
-- rem DESCRIPTON
-- rem   HR (Human Resources) is the smallest and most simple one 
-- rem   of the Sample Schemas
-- rem   
-- rem NOTES
-- rem   Run as SYS or SYSTEM

SET ECHO OFF
SET VERIFY OFF

-- PROMPT 
-- PROMPT specify password for HR as parameter 1:
-- DEFINE pass     = &1
-- PROMPT 
-- PROMPT specify default tablespeace for HR as parameter 2:
-- DEFINE tbs      = &2
-- PROMPT 
-- PROMPT specify temporary tablespace for HR as parameter 3:
-- DEFINE ttbs     = &3
-- PROMPT 
-- PROMPT specify password for SYS as parameter 4:
-- DEFINE pass_sys = &4
-- PROMPT 
-- PROMPT specify log path as parameter 5:
-- DEFINE log_path = &5
-- PROMPT
-- PROMPT specify connect string as parameter 6:
-- DEFINE connect_string     = &6
-- PROMPT

-- The first dot in the spool command below is 
-- the SQL*Plus concatenation character

-- In Oracle SQL*Plus and RMAN, SPOOL is a command used to direct the output of commands and queries to a text file. 
-- This allows users to capture and save the results of their interactions with the Oracle database.
SPOOL ./hr_main.log
CONNECT sys/mysecurepassword@127.0.0.1:51521/XE AS SYSDBA;
alter session set "_ORACLE_SCRIPT"=true;
DROP USER hr CASCADE;

CREATE USER hr IDENTIFIED BY hr;

GRANT execute ON sys.dbms_stats TO hr;

-- REM =======================================================
-- REM cleanup section
-- REM =======================================================

-- REM =======================================================
-- REM create user
-- REM three separate commands, so the create user command 
-- REM will succeed regardless of the existence of the 
-- REM DEMO and TEMP tablespaces 
-- REM =======================================================



-- what is default tablespace?
--  The default tablespace in Oracle is the tablespace that is automatically assigned to a user when they create a new object 
--  (like a table or index) without specifying a different tablespace.
--  It serves as the primary storage location for the user's database objects unless otherwise specified.
--  This is useful for organizing data and managing storage efficiently.
--  The default tablespace is set when the user is created or can be altered later.
ALTER USER hr DEFAULT TABLESPACE &tbs QUOTA UNLIMITED ON &tbs;


-- what is temporary tablespace?
--  The temporary tablespace in Oracle is a special type of tablespace used for storing !!!temporary data!!!! that is created during the execution of SQL statements.
--  It is primarily used for sorting operations, hash joins, and other operations that require temporary storage.
--  Temporary tablespaces are not permanent and are automatically cleared when the database session ends.
--  They help manage memory and disk space efficiently, especially for large queries or operations that require intermediate results.
--  The temporary tablespace is used when a user needs to perform operations that exceed the available memory.
--  It is important to have a properly sized temporary tablespace to avoid performance issues during complex queries or large data manipulations.

ALTER USER hr TEMPORARY TABLESPACE &ttbs;


--  what is create session privilege?
--  The CREATE SESSION privilege in Oracle allows a user to connect to the database.
--  This privilege is essential for any user who needs to interact with the database,
--  as it enables them to establish a session and execute SQL commands.

-- what is alter session privilege?
--  The ALTER SESSION privilege in Oracle allows a user to modify session-level parameters
--  and settings for their current database session. This privilege is often used to change
--  session-specific settings such as NLS (National Language Support) parameters,
--  optimizer settings, and other session characteristics that can affect the behavior of SQL statements.

GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO hr;

--  what is synonym privilege?
--  The CREATE SYNONYM privilege in Oracle allows a user to create synonyms,
GRANT CREATE SYNONYM, CREATE DATABASE LINK, RESOURCE , UNLIMITED TABLESPACE TO hr;

-- REM =======================================================
-- REM grants from sys schema
-- REM =======================================================

-- REM =======================================================
-- REM create hr schema objects
-- REM =======================================================

CONNECT hr/hr@127.0.0.1:51521/XE
ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_TERRITORY=America;

--
-- create tables, sequences and constraint
--

@db-sample-schemas-main/human_resources/hr_cre

-- 
-- populate tables
--

@db-sample-schemas-main/human_resources/hr_popul

--
-- create indexes
--

@db-sample-schemas-main/human_resources/hr_idx

--
-- create procedural objects
--

@db-sample-schemas-main/human_resources/hr_code

--
-- add comments to tables and columns
--

@db-sample-schemas-main/human_resources/hr_comnt

--
-- gather schema statistics
--

@db-sample-schemas-main/human_resources/hr_analz

spool off
