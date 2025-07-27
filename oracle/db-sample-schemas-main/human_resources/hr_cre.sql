-- Rem
-- Rem $Header: hr_cre.sql 29-aug-2002.11:44:03 hyeh Exp $
-- Rem
-- Rem hr_cre.sql
-- Rem
-- Rem Copyright (c) 2001, 2015, Oracle Corporation.  All rights reserved.  
-- Rem 
-- Rem Permission is hereby granted, free of charge, to any person obtaining
-- Rem a copy of this software and associated documentation files (the
-- Rem "Software"), to deal in the Software without restriction, including
-- Rem without limitation the rights to use, copy, modify, merge, publish,
-- Rem distribute, sublicense, and/or sell copies of the Software, and to
-- Rem permit persons to whom the Software is furnished to do so, subject to
-- Rem the following conditions:
-- Rem 
-- Rem The above copyright notice and this permission notice shall be
-- Rem included in all copies or substantial portions of the Software.
-- Rem 
-- Rem THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- Rem EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- Rem MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- Rem NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
-- Rem LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
-- Rem OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-- Rem WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-- Rem
-- Rem    NAME
-- Rem      hr_cre.sql - Create data objects for HR schema
-- Rem
-- Rem    DESCRIPTION
-- Rem      This script creates six tables, associated constraints
-- Rem      and indexes in the human resources (HR) schema.
-- Rem
-- Rem    NOTES
-- Rem
-- Rem    CREATED by Nancy Greenberg, Nagavalli Pataballa - 06/01/00
-- Rem
-- Rem    MODIFIED   (MM/DD/YY)
-- Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
-- Rem    ahunold     09/14/00 - Added emp_details_view
-- Rem    ahunold     02/20/01 - New header
-- Rem    vpatabal	 03/02/01 - Added regions table, modified regions
-- Rem			            column in countries table to NUMBER.
-- Rem			            Added foreign key from countries table
-- Rem			            to regions table on region_id.
-- Rem		                    Removed currency name, currency symbol 
-- Rem			            columns from the countries table.
-- Rem		      	            Removed dn columns from employees and
-- Rem			            departments tables.
-- Rem			            Added sequences.	
-- Rem			            Removed not null constraint from 
-- Rem 			            salary column of the employees table.

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF 

-- REM ********************************************************************
-- REM Create the REGIONS table to hold region information for locations
-- REM HR.LOCATIONS table has a foreign key to this table.

Prompt ******  Creating REGIONS table ....

CREATE TABLE regions
    ( region_id      NUMBER  CONSTRAINT  region_id_nn NOT NULL 
    , region_name    VARCHAR2(25) 
    );

-- REM Create a unique index on the region_id column of the regions table
-- REM to enforce uniqueness and create a primary key constraint.
--  why not use a primary key constraint directly?
--  A unique index is created first to ensure that the region_id values are unique,
--  and then a primary key constraint is added to enforce the uniqueness and    
--  not null constraint on the region_id column.

-- why not set the primary key in create table statement?
-- This approach allows for more flexibility in defining the primary key
-- and ensures that the index is created before the primary key constraint is applied.

CREATE UNIQUE INDEX reg_id_pk ON regions (region_id);
ALTER TABLE regions ADD ( CONSTRAINT reg_id_pk PRIMARY KEY (region_id)) ;

-- REM ********************************************************************
-- REM Create the COUNTRIES table to hold country information for customers
-- REM and company locations. 
-- REM OE.CUSTOMERS table and HR.LOCATIONS have a foreign key to this table.

Prompt ******  Creating COUNTRIES table ....

CREATE TABLE countries 
    ( country_id      CHAR(2)  CONSTRAINT  country_id_nn NOT NULL 
    , country_name    VARCHAR2(40) 
    , region_id       NUMBER 
    , CONSTRAINT     country_c_id_pk PRIMARY KEY (country_id) 
    ) 
    ORGANIZATION INDEX; 

ALTER TABLE countries
ADD (   CONSTRAINT countr_reg_fk
        FOREIGN KEY (region_id)
        REFERENCES regions(region_id) 
    ) ;

-- REM ********************************************************************
-- REM Create the LOCATIONS table to hold address information for company departments.
-- REM HR.DEPARTMENTS has a foreign key to this table.

Prompt ******  Creating LOCATIONS table ....

CREATE TABLE locations
    ( location_id    NUMBER(4)
    , street_address VARCHAR2(40)
    , postal_code    VARCHAR2(12)
    -- Does below CONSTRAINT create anything?
    -- Yes, the CONSTRAINT loc_city_nn NOT NULL ensures that the city column cannot have NULL values.

    --  what is constraint in oracle DB?
    --  A constraint in Oracle DB is a rule that restricts the values that can be stored in a column or a set of columns.
    --  It is used to enforce data integrity and ensure that the data meets certain criteria.
    --  How is constraint enforced?
    --  The constraint is enforced by the database engine, which checks the data against the defined rules before allowing 
    --  any insert or update operations.
    , city       VARCHAR2(30)   CONSTRAINT     loc_city_nn  NOT NULL
    , state_province VARCHAR2(25)
    , country_id     CHAR(2)
    ) ;

-- There is any unique constraint?
-- Yes, the unique constraint is created on the location_id column to ensure that each location has a unique identifier.

-- Why not use primary key constraint directly?
-- What's the diffference between unique and primary key constraint?
-- A unique constraint allows for NULL values, while a primary key constraint does not allow NULL values

-- What's the diffference between unique constraint and unique index?
-- A unique constraint enforces uniqueness on a column or set of columns, while a unique index is an index that enforces uniqueness.


CREATE UNIQUE INDEX loc_id_pk ON locations (location_id) ;

ALTER TABLE locations
ADD ( CONSTRAINT loc_id_pk
       		 PRIMARY KEY (location_id)
    , CONSTRAINT loc_c_id_fk
       		 FOREIGN KEY (country_id)
        	  REFERENCES countries(country_id) 
    ) ;

-- Rem 	Useful for any subsequent addition of rows to locations table
-- Rem 	Starts with 3300

CREATE SEQUENCE locations_seq
 START WITH     3300
 INCREMENT BY   100
 MAXVALUE       9900
 NOCACHE
 NOCYCLE;

-- REM ********************************************************************
-- REM Create the DEPARTMENTS table to hold company department information.
-- REM HR.EMPLOYEES and HR.JOB_HISTORY have a foreign key to this table.

Prompt ******  Creating DEPARTMENTS table ....

CREATE TABLE departments
    ( department_id    NUMBER(4)
    , department_name  VARCHAR2(30)     CONSTRAINT  dept_name_nn  NOT NULL
    , manager_id       NUMBER(6)
    , location_id      NUMBER(4)
    ) ;

CREATE UNIQUE INDEX dept_id_pk ON departments (department_id) ;

ALTER TABLE departments
ADD ( CONSTRAINT dept_id_pk PRIMARY KEY (department_id)
    , CONSTRAINT dept_loc_fk FOREIGN KEY (location_id) REFERENCES locations (location_id)
     ) ;

Rem 	Useful for any subsequent addition of rows to departments table
Rem 	Starts with 280 

CREATE SEQUENCE departments_seq
 START WITH     280
 INCREMENT BY   10
 MAXVALUE       9990
--   what is NOCACHE?
--   NOCACHE means that the sequence will not cache any sequence numbers in memory, which
--   can be useful for ensuring that sequence numbers are always generated in a consistent manner.
 NOCACHE
-- what is NOCYCLE?
-- NOCYCLE means that the sequence will not restart from the beginning once it reaches its maximum
 NOCYCLE;

-- REM ********************************************************************
-- REM Create the JOBS table to hold the different names of job roles within the company.
-- REM HR.EMPLOYEES has a foreign key to this table.

Prompt ******  Creating JOBS table ....

CREATE TABLE jobs
    ( job_id         VARCHAR2(10)
    , job_title      VARCHAR2(35)   CONSTRAINT     job_title_nn  NOT NULL
    , min_salary     NUMBER(6)
    , max_salary     NUMBER(6)
    ) ;

CREATE UNIQUE INDEX job_id_pk  ON jobs (job_id) ;

ALTER TABLE jobs
ADD ( CONSTRAINT job_id_pk PRIMARY KEY(job_id)
    , CONSTRAINT job_salary_ck CHECK (min_salary < max_salary)
    , CONSTRAINT job_salary_min CHECK (min_salary >= 0  AND max_salary >= 0)
    ) ;

REM ********************************************************************
REM Create the EMPLOYEES table to hold the employee personnel information for the company.
REM HR.EMPLOYEES has a self referencing foreign key to this table.

Prompt ******  Creating EMPLOYEES table ....

CREATE TABLE employees
    ( employee_id    NUMBER(6)
    , first_name     VARCHAR2(20)
    , last_name      VARCHAR2(25)   CONSTRAINT     emp_last_name_nn  NOT NULL
    , email          VARCHAR2(25)   CONSTRAINT     emp_email_nn  NOT NULL
    , phone_number   VARCHAR2(20)
    , hire_date      DATE           CONSTRAINT     emp_hire_date_nn  NOT NULL
    , job_id         VARCHAR2(10)   CONSTRAINT     emp_job_nn  NOT NULL
    , salary         NUMBER(8,2)
    , commission_pct NUMBER(2,2)
    , manager_id     NUMBER(6)
    , department_id  NUMBER(4)
    , CONSTRAINT     emp_salary_min CHECK (salary > 0) 
    , CONSTRAINT     emp_email_uk   UNIQUE (email)
    ) ;

CREATE UNIQUE INDEX emp_emp_id_pk   ON employees (employee_id) ;


ALTER TABLE employees
ADD ( CONSTRAINT     emp_emp_id_pk  PRIMARY KEY (employee_id)
--  why is below constraint referencing table?
--  The constraint is referencing the departments table to ensure that the department_id in the employees table
--  corresponds to a valid department in the departments table. 

--  why is column name missing in below constraint?
--  The column name is not specified in the constraint because it is implied that the department_id
--  column in the employees table is the one being referenced.

    , CONSTRAINT     emp_dept_fk    FOREIGN KEY (department_id) REFERENCES departments

    --  why is job_id column is specified in below constraint?
    --  The job_id column is specified in the constraint to establish a foreign key relationship with
    --  the jobs table, ensuring that the job_id in the employees table corresponds to a valid job in the jobs table.
    , CONSTRAINT     emp_job_fk     FOREIGN KEY (job_id)        REFERENCES jobs (job_id)
    , CONSTRAINT     emp_manager_fk FOREIGN KEY (manager_id)    REFERENCES employees
    ) ;

ALTER TABLE departments
ADD ( CONSTRAINT dept_mgr_fk        FOREIGN KEY (manager_id)    REFERENCES employees (employee_id)) ;

-- Rem 	Useful for any subsequent addition of rows to employees table
-- Rem 	Starts with 207 


CREATE SEQUENCE employees_seq
 START WITH     207
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

-- REM ********************************************************************
-- REM Create the JOB_HISTORY table to hold the history of jobs that 
-- REM employees have held in the past.
-- REM HR.JOBS, HR_DEPARTMENTS, and HR.EMPLOYEES have a foreign key to this table.

Prompt ******  Creating JOB_HISTORY table ....

CREATE TABLE job_history
    ( employee_id   NUMBER(6)   CONSTRAINT    jhist_employee_nn  NOT NULL
    , start_date    DATE        CONSTRAINT    jhist_start_date_nn  NOT NULL
    , end_date      DATE        CONSTRAINT    jhist_end_date_nn  NOT NULL
    , job_id        VARCHAR2(10)    CONSTRAINT    jhist_job_nn  NOT NULL
    , department_id NUMBER(4)
    , CONSTRAINT    jhist_date_interval CHECK (end_date > start_date)
    ) ;

CREATE UNIQUE INDEX jhist_emp_id_st_date_pk ON job_history (employee_id, start_date) ;

ALTER TABLE job_history
ADD ( CONSTRAINT jhist_emp_id_st_date_pk
      PRIMARY KEY (employee_id, start_date)
    , CONSTRAINT     jhist_job_fk
                     FOREIGN KEY (job_id)
                     REFERENCES jobs
    , CONSTRAINT     jhist_emp_fk
                     FOREIGN KEY (employee_id)
                     REFERENCES employees
    , CONSTRAINT     jhist_dept_fk
                     FOREIGN KEY (department_id)
                     REFERENCES departments
    ) ;

REM ********************************************************************
REM Create the EMP_DETAILS_VIEW that joins the employees, jobs, 
REM departments, jobs, countries, and locations table to provide details
REM about employees.

Prompt ******  Creating EMP_DETAILS_VIEW view ...

CREATE OR REPLACE VIEW emp_details_view
  (employee_id,
   job_id,
   manager_id,
   department_id,
   location_id,
   country_id,
   first_name,
   last_name,
   salary,
   commission_pct,
   department_name,
   job_title,
   city,
   state_province,
   country_name,
   region_name)
AS SELECT
  e.employee_id, 
  e.job_id, 
  e.manager_id, 
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id 
WITH READ ONLY;

COMMIT;
