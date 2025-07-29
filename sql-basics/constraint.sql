https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/create-table-foreign-keys.html


-- 插入数据时候，通常为了防止数据不一致，需要先禁用外键约束。
-- 例如，插入员工数据时，如果部门表中没有对应的部门ID，
-- 则会导致外键约束错误。因此，先禁用部门表的外键约束，
-- 然后再插入数据，最后再启用外键约束。



Grammar: 

ALTER TABLE departments DISABLE CONSTRAINT dept_mgr_fk;

  

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

ALTER TABLE departments ADD ( CONSTRAINT dept_mgr_fk        FOREIGN KEY (manager_id)    REFERENCES employees (employee_id)) ;
