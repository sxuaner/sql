
create user AURORA identified by xuansong;


-- create a tablespace and assign it to the user. Instead of using defaul?
CREATE TABLESPACE AuroraTS datafile 'auroraTS.dat' size 100M;

--  An attempt was made to create a common user or role with a name that was not valid for common users or roles.  In addition to the usual rules for user 
-- and role names, common user and role names must start with C## or c## and consist only of ASCII characters.
alter session set "_ORACLE_SCRIPT"=true;


CREATE USER aurora identified by geheim DEFAULT TABLESPACE AuroraTS;

grant all privileges to aurora;


-- delete a user
drop user aurora CASCADE;

-- choose oracleDB connection and run following command to see all existing users in db.
select * from all_users;



-- create table;
CREATE TABLE C##aurora.customers
( customer_id number(10) NOT NULL,
  customer_name varchar2(50) NOT NULL,
  city varchar2(50)
);

-- drop table
drop table C##aurora.customers;