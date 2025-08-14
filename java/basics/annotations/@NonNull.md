
Example:
```java
List<@NonNull String> names;
```

the @NonNull annotation is applied directly to the type argument String. This means that every element in the names list is expected to be non-null.

The @NonNull annotation itself does not enforce this rule at runtime. Instead, it is used by tools such as static analyzers or custom type checkers to detect possible null-related errors during development. If you try to add a null value to the list, these tools can warn you or produce an error.

Summary:
@NonNull helps catch mistakes (like adding null to the list) before your code runs, improving code safety and reliability.


