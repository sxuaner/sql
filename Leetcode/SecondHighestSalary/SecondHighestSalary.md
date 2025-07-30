# 176. 第二高的薪水

## SQL Schema

**Employee 表:**

| Column Name | Type |
|-------------|------|
| id          | int  |
| salary      | int  |

- `id` 是这个表的主键。
- 表的每一行包含员工的工资信息。

---
## 题目描述
查询并返回 Employee 表中**第二高的不同薪水**。如果不存在第二高的薪水，查询应该返回 `null`（Pandas 则返回 `None`）。
---

## 示例

**示例 1:**

输入：

| id | salary |
|----|--------|
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |

输出：

| SecondHighestSalary |
|---------------------|
| 200                 |

---

**示例 2:**

输入：

| id | salary |
|----|--------|
| 1  | 100    |

输出：

| SecondHighestSalary |
|---------------------|
| null                |

---

## SQL Query

### 分析

- **第二高**：可以使用 `LIMIT` 和 `OFFSET` 获取第二高的薪水。
- **不同**：可以使用 `DISTINCT` 去重。
- `ORDER BY` 通常与 `IS NOT NULL` 一起使用，剔除 `null` 值。

### 查询解释

```sql
SELECT DISTINCT salary AS SecondHighestSalary
FROM Employee
WHERE salary IS NOT NULL
ORDER BY salary DESC
LIMIT 1 OFFSET 1;
```

1. `SELECT DISTINCT salary AS SecondHighestSalary`  
   选择不同的薪水，并命名为 SecondHighestSalary。
2. `FROM Employee`  
   从 Employee 表中查询。
3. `WHERE salary IS NOT NULL`  
   确保薪水不为 NULL。
4. `ORDER BY salary DESC`  
   按薪水降序排列，最高薪水在前。
5. `LIMIT 1`  
   只返回一行。
6. `OFFSET 1`  
   跳过第一行（最高薪水），获取第二高的薪水。

---

### OFFSET 作用

`OFFSET` 用于跳过指定数量的行。在本查询中，`OFFSET 1` 表示跳过第一行（最高薪水），获取第二高的薪水。

> [Oracle OFFSET 文档](https://docs.oracle.com/en/database/other-databases/nosql-database/19.5/sqlreferencefornosql/offset-clause.html)  
> 虽然可以在没有 `ORDER BY` 的情况下使用 `OFFSET`，但这样做没有意义，因为结果顺序是随机的，每次查询跳过的结果可能不同。

---

## LIMIT 和 OFFSET 的两种写法

- `SELECT column_list FROM table LIMIT offset, row_count;`
- `SELECT column_list FROM table LIMIT row_count OFFSET offset;`

---

## Oracle SQL 限制返回行数的方法

在 Oracle SQL 中，限制 SELECT 语句返回的行数有多种方式，具体取决于 Oracle 版本和需求：

### 1. 使用 ROWNUM（适用于 Oracle 12c 之前，也依然可用）

`ROWNUM` 伪列为每行分配一个从 1 开始的序号。可以在 WHERE 子句中使用它来限制结果集的行数。

```sql
SELECT *
FROM your_table
WHERE ROWNUM <= 10; -- 返回前 10 行
```

**注意**：如果结合 `ORDER BY` 使用，需将排序放在子查询中，确保排序后再应用 ROWNUM。

```sql
SELECT *
FROM (
    SELECT *
    FROM your_table
    ORDER BY column_name
)
WHERE ROWNUM <= 10;
```

### 2. 使用 FETCH FIRST 和 OFFSET（Oracle 12c 及以后版本）

Oracle 12c 引入了 `FETCH FIRST` 和 `OFFSET`，语法更直观，符合 SQL:2008 标准。

- **FETCH FIRST n ROWS ONLY**：返回前 n 行。

    ```sql
    SELECT *
    FROM your_table
    ORDER BY column_name
    FETCH FIRST 10 ROWS ONLY;
    ```

- **OFFSET n ROWS FETCH NEXT m ROWS ONLY**：跳过前 n 行，返回接下来的 m 行，常用于分页。

    ```sql
    SELECT *
    FROM your_table
    ORDER BY column_name
    OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY; -- 跳过 10 行，返回接下来的 5 行
    ```

- **WITH TIES**：结合 `ORDER BY`，返回与最后一行排序值相同的所有行。

    ```sql
    SELECT *
    FROM your_table
    ORDER BY column_name
    FETCH FIRST 10 ROWS WITH TIES;
    ```

### 3. 使用 FETCH 的 PERCENT 选项（Oracle 12c 及以后版本）

可以指定返回结果的百分比。

```sql
SELECT *
FROM your_table
ORDER BY column_name
FETCH FIRST 50 PERCENT ROWS ONLY; -- 返回前 50% 的行
```



