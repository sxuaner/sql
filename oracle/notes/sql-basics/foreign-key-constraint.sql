--  Referential Integrity  
--  Referential integrity in database management ensures the consistency of relationships between tables. It means that a foreign key 
-- (a column in one table referencing another) must always point to a valid, existing primary key in the related table, or be NULL if allowed. 
-- This prevents orphaned records (records that refer to non-existent data) and maintains the logical connections between related data.


-- Referential Integrity Constraint:
-- Referential integrity is enforced through constraints, often foreign key constraints. These constraints ensure that any value used as 
-- a foreign key in one table must exist as a primary key value in the related table.


--   两个表数据如果没有关联，删除一个表的数据会导致另一个表的数据出错

-- 比如客户和订单2个表， 如果客户被删除了，订单表中对应的客户ID就会变成无效的引用， 也就是去查的时候， 查不到客户的信息。这时候为了保证代码运行时候不出问题，
-- 或者业务逻辑清晰，
-- 就需要在删除客户的时候， 也把订单表中对应的客户ID删除掉， 这样就不会有无效的引用了。
-- 这就是外键约束的作用， 它可以保证数据的完整性和一致性。

-- 或者把foreign key设置为ON DELETE SET NULL, 这样在删除客户的时候， 订单表中对应的客户ID会被设置为NULL，而不是删除掉。
-- 这样就可以保留订单表中的数据，同时也不会有无效的引用

-- 或者把foreign key constraint删掉，不过这样就会失去数据的完整性和一致性，可能会导致数据错误或者业务逻辑混乱。
-- 所以一般情况下，还是建议使用外键约束来保证数据的完整性