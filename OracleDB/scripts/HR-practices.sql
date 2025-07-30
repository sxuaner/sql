









------------------- 

CREATE TABLE items(val number);
INSERT INTO items(val) VALUES(1);
INSERT INTO items(val) VALUES(1);
INSERT INTO items(val) VALUES(2);
INSERT INTO items(val) VALUES(3);
INSERT INTO items(val) VALUES(NULL);
INSERT INTO items(val) VALUES(4);
INSERT INTO items(val) VALUES(NULL);

SELECT * FROM items;

SELECT COUNT(*) from ITEMS;

SELECT COUNT( DISTINCT val ) FROM items;
    
COMMIT;


SELECT department_id, MAX(salary)
  FROM employees
  GROUP BY department_id
  HAVING MAX(salary) > 5000;

SELECT COUNT(distinct salary) FROM employees GROUP BY department_id;
SELECT department_id, COUNT(distinct salary) FROM employees GROUP by department_id;

SELECT department_id NOT NULL, COUNT(distinct salary) FROM employees GROUP by department_id;

SELECT department_id, COUNT(distinct salary) FROM employees GROUP by department_id WHERE department_id IS NOT NULL;

SELECT department_id, COUNT(distinct salary) FROM employees GROUP by department_id HAVING department_id IS NOT NULL;

SELECT department_id FROM employees WHERE department_id IS NOT NULL GROUP BY department_id;


create table toys (
  toy_id               integer not null primary key,
  toy_name             varchar2(100) not null,
  weight               number(10, 2) not null,
  quantity_of_stuffing integer,
  volume_of_wood       integer,
  times_lost           integer
);

insert into toys values (1, 'Mr. Penguin', 50, 100, null, 10);
insert into toys values (2, 'Blue Brick', 10, null, 10, null);
insert into toys values (3, 'Red Brick', 20, null, 20, 1);
commit;


select t.*,
       coalesce ( volume_of_wood , 0 ) coalesce_two,
       coalesce ( times_lost, volume_of_wood , quantity_of_stuffing, 0 ) coalesce_many
from   toys t;


-- Complete the following statement to create a table with the following columns:
-- brick_id of type number(20, 0)
-- colour of type varchar2, max size 10
-- price of type number with precision 10 and scale 2
-- purchased_date of type date.

CREATE TABLE try_it(
  brick_id number(20),
  colour varchar2(10),
  price number(10,2),
  purchased_date date
);      -- Don't forget semicolumn here

desc toys;
-- How to end a session?
-- what is this default profile?

----------------------  ----------------------- 
