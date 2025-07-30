In Oracle SQL, limiting the number of rows returned by a SELECT statement can be achieved using various methods, depending on the Oracle version and specific requirements.
## 1. Using ROWNUM (Older Versions and General Use)

The `ROWNUM` pseudocolumn assigns a sequential number to each row as it is retrieved. This is a common way to limit results in older Oracle versions or when a simple row limit is needed.

```sql
SELECT *
FROM your_table
WHERE ROWNUM <= N; -- N is the desired number of rows
```

> **Note:** `ROWNUM` is assigned before any `ORDER BY` is applied. If you need sorted results, use a subquery:

```sql
SELECT *
FROM (
    SELECT *
    FROM your_table
    ORDER BY your_column DESC
)
WHERE ROWNUM <= N;
```

---

## 2. FETCH FIRST / NEXT (Oracle 12c and Later)

Starting with Oracle 12c, you can use the `FETCH FIRST` or `FETCH NEXT` clause, which is similar to `LIMIT` in other databases.(Read FETCH FIRST AND FETCH NEXT)

```sql
SELECT *
FROM your_table
ORDER BY your_column
FETCH FIRST N ROWS ONLY; -- N is the desired number of rows
```

To include rows with the same value at the limit (ties), use `WITH TIES`:

```sql
SELECT *
FROM your_table
ORDER BY your_column
FETCH FIRST N ROWS WITH TIES;
```

---

## 3. OFFSET and FETCH (Pagination)

The `OFFSET` clause lets you skip a number of rows before fetching, which is useful for pagination.

```sql
SELECT *
FROM your_table
ORDER BY your_column
OFFSET M ROWS FETCH NEXT N ROWS ONLY; -- M: rows to skip, N: rows to fetch
```

This allows you to retrieve specific "pages" of data from a larger result set.