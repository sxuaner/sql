In general, you should create an index on a column in any of the following situations:

The column is queried frequently.
A referential integrity constraint exists on the column.
A UNIQUE key integrity constraint exists on the column

-- As was already explained in other answers: constraints and the indexes are different entities. But they lack precise definitions and 
-- official comments on the topic. Before we discuss the relationship between these two entities lets take a look at their purpose 
-- independent of each other.

-- Purpose of a constraint1:
-- Use a constraint to define an integrity constraint-- a rule that restricts the values in a database.

-- The purposes of an index2:
-- You can create indexes on columns to speed up queries. Indexes provide faster access to data for operations that return a small portion of a table's rows.

-- In general, you should create an index on a column in any of the following situations:

-- The column is queried frequently.
-- A referential integrity constraint exists on the column.
-- A UNIQUE key integrity constraint exists on the column.
-- Now we know what constraints and indexes are, but what is the relationship between them?
-- The relationship between indexes and constraints is3:

-- a constraint MIGHT create an index or use an existing index to efficient enforce itself. For example, a PRIMARY KEY constraint will either create an index (unique or non-unique depending) or it will find an existing suitable index and use it.

-- an index has nothing to do with a constraint. An index is an index.

-- So, a constraint MIGHT create/use and index. An INDEX is an INDEX, nothing more, nothing less.

-- So sum this up and directly address the following sentence from your question:

-- However, I don't understand the reason for unique index without constraint.

-- Indexes speed up queries and integrity checks (constraints). Also for conditional uniqueness a unique (functional) index is used as this cannot be achieved with a constraint.

-- Hopefully this brings a little bit more clarification to the whole topic, but there is one aspect of the original question that remains unanswered:

-- Why did the following error occur when no constraint existed:
-- ORA-00001: unique constraint (TEST.IDX_TEST22) violated

-- The answer is simple: there is no constraint and the error message misnames it!

-- See the official "Oracle Ask TOM" comment 4 on the same problem:

-- It isn't a constraint. the error message "misnames" it.
-- If it were a constraint, you could create a foreign key to it -- but you cannot.




-- Q:  Given there are are only male and female employees in the employees table, will index on the gender column be useful?
-- A:  No, because there are only two   distinct values

-- How is indexn implemented in Oracle?
-- An index in Oracle is implemented as a B-tree structure, which allows for efficient searching,
-- insertion, and deletion of records. The B-tree structure maintains a balanced tree where each node contains keys and pointers to child nodes, enabling quick access to data.
-- The index is stored in a separate segment in the database, and it can be created on one or more columns of a table.


-- In summary: For small datasets, the overhead and complexity of B-trees outweigh their potential benefits, and simpler data structures like binary search trees or arrays 
-- are usually a better choice. B-trees are most beneficial when dealing with very large datasets that cannot be held entirely in memory and where disk access patterns need 
-- to be optimized. 