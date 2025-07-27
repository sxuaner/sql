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

A clustered index is a type of database index that determines the physical order of data rows in a table. In systems like SQL Server, a clustered index sorts and stores the data rows of the table based on the indexed columns, so there can be only one clustered index per table.

In Oracle, the concept is different:

Oracle does not have traditional clustered indexes like SQL Server.
Instead, Oracle uses Index-Organized Tables (IOTs), where the table data is stored in the order of the primary key within the index structure itself. This acts like a clustered index.
Oracle also supports clusters, which group related tables together in the same data blocks based on a cluster key, but this is different from a clustered index in SQL Server.
Summary:

In SQL Server: Clustered index = physical order of table rows.
In Oracle: Use IOTs for similar behavior; regular indexes do not affect row order.




Oracle's approach to clustered indexes differs from other database systems like SQL Server. While SQL Server uses a clustered index to physically sort the data rows in the table based on the indexed columns, Oracle achieves a similar effect through Index-Organized Tables (IOTs) and clusters.
Index-Organized Tables (IOTs):
An IOT stores the entire table data within the primary key index structure. This means the data is physically sorted and stored in the order of the primary key, eliminating the need for a separate heap table and improving performance for queries that access data based on the primary key.
The primary key of an IOT acts as the "clustered index" in the sense that it dictates the physical storage order of the data.
IOTs are particularly useful for tables where data is frequently accessed via the primary key or where the table is relatively small and the primary key is highly selective.
Clusters:
Oracle also offers the concept of clusters, which group related tables together in the same data blocks based on a common cluster key.
This is beneficial when tables are frequently joined on the cluster key, as it can reduce I/O operations by storing related rows physically close to each other.
A cluster index is then created on the cluster key, allowing efficient access to the clustered data.
Key Differences from SQL Server's Clustered Index:
Physical Data Ordering:
In Oracle, only IOTs directly store the entire table data within the index structure, physically sorting it by the primary key. Regular indexes in Oracle are B-tree structures that point to the rowids in a separate heap-organized table.
One per Table:
While SQL Server allows only one clustered index per table, Oracle can have multiple indexes on a heap-organized table, and IOTs are a specific table type with their data organized by the primary key.
Purpose:
Oracle's IOTs are primarily for performance optimization when accessing data via the primary key, while clusters are for optimizing joins between related tables.