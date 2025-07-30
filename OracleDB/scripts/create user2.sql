
create user AURORA identified by xuansong;


-- create a tablespace and assign it to the user.
CREATE TABLESPACE hibernate datafile 'hibernate.dat' size 100M;


-- to add users without C##
alter session set "_ORACLE_SCRIPT"=true;

CREATE USER hibernate identified by xuansong DEFAULT TABLESPACE hibernate;
grant all privileges to hibernate;


-- In order to drop a user, you must have the Oracle DROP USER system privilege. 
-- If a user owns any database objects, that user can only be dropped with the Oracle DROP USER CASCADE command. The Oracle DROP USER CASCADE command drops a user and all owned objects.
-- DDL Statements
-- DDL refers to "Data Definition Language", a subset of SQL statements that change the structure of the database schema in some way, 
-- typically by creating, deleting, or modifying schema objects such as databases, tables, and views. Most Impala DDL statements start with the keywords CREATE, DROP, or ALTER.
drop user aurora CASCADE;

-- choose oracleDB connection and run following command to see all existing users in db.
select * from all_users;


-- create table;
CREATE TABLE C##aurora.customers
( customer_id number(10) NOT NULL,
  customer_name varchar2(50) NOT NULL,
  city varchar2(50)
);


-- delete all entries
delete from aurora.log;
-- delete table
drop table aurora.log;

-- change password
alter user TRANAPI identified by xuansong;

alter user sys identified by xuansong;

-- unlock user
grant create session to TRANAPI;

ALTER USER TRANAPI ACCOUNT UNLOCK;
