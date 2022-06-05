-- left outer join

-- and you'll use LEFT JOIN when you need all records from the “left” table, no matter if they have pair in the “right” table or not.

-- A left join is used when a user wants to extract the left table's data only

-- inner join, 
-- You'll use INNER JOIN when you want to return only records having pair on both sides. 

-- because it's seleting from departments, the columns from departments will be displayed first
SELECT * FROM departments INNER JOIN employees ON departments.department_id=employees.DEPARTMENT_ID;

-- vice versa
SELECT * FROM  employees INNER JOIN departments ON departments.department_id=employees.DEPARTMENT_ID;



select * from employees;
select * from departments;

desc employees;
desc departments;

