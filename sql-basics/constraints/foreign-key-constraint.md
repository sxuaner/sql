## Referential Integrity

Referential integrity in database management ensures the consistency of relationships between tables. It means that a foreign key (a column in one table referencing another) must always point to a valid, existing primary key in the related table, or be `NULL` if allowed. This prevents orphaned records (records that refer to non-existent data) and maintains logical connections between related data.

### Referential Integrity Constraint

Referential integrity is enforced through constraints, most commonly foreign key constraints. These constraints ensure that any value used as a foreign key in one table must exist as a primary key value in the related table.

---

### 外键约束的作用

如果两个表之间的数据没有关联，删除一个表的数据可能会导致另一个表的数据出错。

例如，假设有“客户”和“订单”两个表。如果客户被删除了，订单表中对应的客户ID就会变成无效引用，查询时无法找到对应的客户信息。为了保证代码运行正常、业务逻辑清晰，需要在删除客户时，同时删除订单表中对应的客户ID，避免无效引用。这就是外键约束的作用，它可以保证数据的完整性和一致性。

外键约束还可以设置为 `ON DELETE SET NULL`，这样在删除客户时，订单表中对应的客户ID会被设置为 `NULL`，而不是直接删除订单数据。这样可以保留订单表中的数据，同时避免无效引用。

当然，也可以删除外键约束，但这样会失去数据的完整性和一致性，可能导致数据错误或业务逻辑混乱。因此，通常建议使用外键约束来保证数据的完整性。

---

### 插入数据时的外键约束

在批量插入数据时，为了防止数据不一致，通常会先临时禁用外键约束。例如，插入员工数据时，如果部门表中没有对应的部门ID，会导致外键约束错误。此时可以先禁用部门表的外键约束，插入数据后再重新启用外键约束。
