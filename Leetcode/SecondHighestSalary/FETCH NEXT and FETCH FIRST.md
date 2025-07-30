## FETCH FIRST and FETCH NEXT in SQL

In SQL, `FETCH FIRST` and `FETCH NEXT` are keywords used with the `OFFSET...FETCH` clause—typically alongside an `ORDER BY`—to limit the number of rows returned by a query.

### Functionality

Both `FETCH FIRST` and `FETCH NEXT` serve the same purpose:  
They specify the maximum number of rows to retrieve after an optional `OFFSET`.

- **FETCH FIRST** is often used to fetch the initial _n_ rows of a result set.  
    Example:  
    ```sql
    FETCH FIRST 10 ROWS ONLY
    ```
- **FETCH NEXT** is generally preferred with an `OFFSET` clause, making the intent clearer.  
    Example:  
    ```sql
    OFFSET 5 ROWS FETCH NEXT 10 ROWS ONLY
    ```
    This fetches the next 10 rows after skipping the first 5.

### Examples

Suppose you have a table `Products` with columns `ProductID` and `ProductName`.

**Retrieve the first 5 products:**
```sql
SELECT ProductID, ProductName
FROM Products
ORDER BY ProductID
FETCH FIRST 5 ROWS ONLY;
```

**Retrieve the next 5 products after skipping the first 10:**
```sql
SELECT ProductID, ProductName
FROM Products
ORDER BY ProductID
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;
```

### Key Points

- The `OFFSET...FETCH` clause is part of the SQL standard and is supported by databases like PostgreSQL, Oracle (12c+), and SQL Server.
- The keywords `ROW` and `ROWS` can be used interchangeably (e.g., `FETCH FIRST 1 ROW ONLY` or `FETCH FIRST 1 ROWS ONLY`).
- Some systems (like PostgreSQL) support `WITH TIES` in the `FETCH` clause to include all rows that have the same rank as the last row in the fetched set, even if it exceeds the specified count.