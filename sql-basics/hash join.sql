--  what is hash join in Oracle?
Probe: /to examine something with a tool, especially in order to find something that is hidden:/
--  A hash join in Oracle is a type of join operation that uses a hash table to match rows from two tables based on a join condition.
--  The process involves creating a hash table for one of the tables (usually the smaller one) and then probing this hash table with rows from the other table.

Advantages:
-- 1. **Efficiency:** Hash joins are particularly efficient for large datasets, especially when the data does not fit into memory.


-- 2. **Reduced Disk I/O:** They minimize the number of disk I/O operations required to retrieve the data, as they only need to read each table once.

-- 3. **Flexibility:** Hash joins can handle complex join conditions and are not limited to equality joins.

-- 4. **Automatic Selection:** The Oracle optimizer automatically chooses hash joins when it determines they will provide better performance than other join methods, 
-- such as nested loops or sort-merge joins.

-- 5. **Memory Management:** They can efficiently manage memory usage by using a hash table to store the join keys, allowing for quick lookups during the join operation.

-- 6. **Scalability:** Hash joins can scale well with increasing data sizes, making them suitable for large datasets commonly found in data warehousing and analytical queries.

-- 7. **Parallel Execution:** Hash joins can be executed in parallel, further improving performance

-- 8. **Join Conditions:** They are particularly effective for equality joins, where the join condition involves matching values from both tables.

-- 9. **Handling Skewed Data:** Hash joins can handle skewed data distributions

-- 10. **Memory Usage:** They can consume significant memory resources, so it's important to monitor and manage memory usage when using hash joins in large queries.

-- 11. **Temporary Tablespace:** If the hash table exceeds available memory, Oracle uses temporary tablespace to store the hash table, which can impact performance.

-- 12. **Join Types:** Hash joins can be used for inner joins, outer joins, and anti-joins, making them versatile for various query types.

-- 13. **Optimizer Statistics:** The Oracle optimizer uses statistics about the tables and their data to determine whether a hash join is the best choice for a given query.
-- 14. **Cost-Based Optimization:** The optimizer evaluates the cost of using a hash join compared to other join methods, such as nested loops or sort-merge joins, to select the most efficient execution plan.


--  They can also be used in conjunction with other join methods, such as nested loops or sort-merge joins, depending on the specific query and data characteristics.
--  Hash joins are particularly useful in data warehousing and analytical queries where large datasets need to be processed efficiently.
--  They help improve query performance by minimizing the number of disk I/O operations required to retrieve the data.
--  Hash joins are typically chosen by the Oracle optimizer when it determines that they will provide the best performance for a given query.
--  However, they can consume significant memory resources, so it's important to monitor and manage memory usage when using hash joins in large queries.
--  The temporary tablespace is used when a user needs to perform operations that exceed the available memory.
--  It is important to have a properly sized temporary tablespace to avoid performance issues during complex queries or large data manipulations.
--  The hash join algorithm is particularly effective when dealing with large datasets that do not fit into memory, as it allows for efficient processing of data in chunks.
--  The hash join operation is typically performed in two phases: the build phase and the probe phase.
--  In the build phase, the smaller table is scanned, and a hash table is created based on the join key.
--  In the probe phase, the larger table is scanned, and each row is hashed to find matching rows in the hash table.



-- Oracle's implementation of a hash join is designed for efficiently joining larger datasets, particularly when an equijoin condition exists. 

The process involves two main phases: the build phase and the probe phase.

1. Build Phase:
Oracle identifies the smaller of the two datasets involved in the join, designating it as the "build table" or "driving row source."
It then scans this build table and constructs an in-memory hash table using the join key(s). A deterministic hash function is applied to the join column(s) of each row 
to determine its location within the hash table.If the build table is too large to fit entirely in memory, Oracle may partition both datasets and process them in segments, 
potentially writing partitions to temporary disk space.

2. Probe Phase:
Oracle then scans the larger dataset, referred to as the "probe table" or "probe row source."
For each row in the probe table, the same hash function used in the build phase is applied to its join column(s).
The resulting hash value is used to probe the in-memory hash table built from the smaller table.
If a matching entry is found, Oracle retrieves the corresponding row(s) from the build table and combines them with the current row from the probe table, forming the joined 
result set.Hash collisions, where different input values produce the same hash value, are handled by checking the actual values of the join columns to ensure correct matches.

Key Characteristics and Considerations:
Equijoin Requirement:
Hash joins are exclusively used for equijoins (joins based on equality conditions, e.g., table1.col = table2.col).

Memory Utilization:
The performance of hash joins is highly dependent on the availability of memory (PGA Program Global Area). If the build table can fit entirely in memory, performance is optimal. Otherwise, disk I/O for partitioning can impact performance.

Indexing Strategy:
Unlike nested loops joins, indexes on the join columns are not typically beneficial for hash joins, as the access method relies on hashing rather than index lookups. 
Indexes on independent WHERE clause predicates, however, can still improve performance by reducing the number of rows processed before the join.

Optimization:
Oracle's optimizer automatically chooses hash joins when deemed appropriate, especially for large datasets. Hints like /*+ USE_HASH(table_alias) */ can be used to explicitly 
suggest a hash join.

In-Memory Optimization:
For In-Memory databases, Oracle leverages features like deep vectorization and SIMD vector processing to further optimize hash join performance by accelerating hashing, 
building, probing, and gathering operations.




Here's a breakdown of when and why hash joins are preferred:

Joining Large, Unsorted Tables:
Hash joins are generally efficient for joining two large tables where neither is sorted on the join key. This is because they do not require prior sorting, unlike sort-merge joins.

Equi-joins:
Hash joins are particularly well-suited for equi-joins (joins based on equality conditions, e.g., table1.col = table2.col).

Memory Availability:
Hash joins perform best when the smaller of the two tables being joined can fit entirely or largely within the available PGA (Program Global Area) memory. This allows the database to build a hash table in memory efficiently.

Handling Spilling to Disk:
Even if the smaller table doesn't entirely fit in memory, Oracle can still use a hash join by "spilling" parts of the hash table to temporary segments on disk. While this can impact performance, it allows hash joins to be used with very large tables that exceed available memory.

Optimizer Choice:
The CBO determines the most appropriate join method based on factors like table sizes, statistics, available memory, and the nature of the join condition. If the CBO estimates that a hash join will result in the lowest cost (fastest execution time), it will choose this method.

How it works (briefly)
Oracle builds a hash table in memory using the rows from the smaller of the two joined tables, based on the join key.
It then scans the larger table, probing the hash table to find matching rows. 

Hash joins are a powerful and commonly used join method in Oracle for efficient processing of large data volumes.