-- This script creates a dummy employee table and inserts some sample data.
.mode markdown
.tables

DROP TABLE employee;

-- Create a dummy employee table:
CREATE TABLE employee (
     id INTEGER PRIMARY KEY,
     name TEXT NOT NULL,
     position TEXT,
     salary REAL,
     gender TEXT
);

-- # Insert some dummy data:
INSERT INTO employee (name, position, salary, gender) VALUES
     ('Alice', 'Manager', 75000, 'female'),
     ('Bob', 'Developer', 60000, 'male'),
     ('Charlie', 'Designer', 55000, 'male');

select * from employee;

-- .read notes/sqllite3/scripts/init.sql
