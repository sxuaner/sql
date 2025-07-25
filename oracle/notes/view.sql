-- what's view in oracle for?
-- A view in Oracle is a virtual table that is based on the result of a SQL query. It does not store data itself but provides a way to present 
-- data from one or more tables in a specific format or structure.

-- Views can simplify complex queries, enhance security by restricting access to specific data, and provide a   
-- consistent interface to the underlying data. They can also be used to encapsulate complex joins and aggregations, making it easier for users 
-- to work with the data.
-- Views can be queried like regular tables, and they can also be used in joins, subqueries, and other SQL operations.
-- Views can be updated, but there are restrictions on which views can be updated based on the complexity of the underlying query and the 
-- presence of certain features like joins or aggregations.
-- Views can also be used to enforce security by restricting access to specific columns or rows of data 
-- without exposing the underlying tables directly.


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