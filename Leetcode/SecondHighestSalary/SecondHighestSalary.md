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
