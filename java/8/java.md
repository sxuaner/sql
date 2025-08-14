https://www.oracle.com/java/technologies/javase/8-whats-new.html


Java:
引入lambda expression. 功能代码可以被当做方法的入参，或者把代码当做数据。Lambda Expression可更简洁方便的创建functional interface的子类

有名字的方法可以通过易读的lambda expression 被调用，这个叫做Method reference

Default methods 使代码库的接口可以加入新的功能，同时保证了和老版本的二进制兼容性

同一注解可以多次使用

增强类型推论功能

函数入参反射






函数入参反射
========================= Q ===============================
In Java 8, method parameter reflection means you can use the reflection API to get the names of method parameters at runtime, if the code was compiled with the -parameters compiler option.

Previously, you could only get parameter types, not their names. With Java 8, you can write:

```java
Method method = MyClass.class.getMethod("myMethod", String.class);
Parameter[] params = method.getParameters();
for (Parameter param : params) {
    System.out.println(param.getName());
}
```

If compiled with javac -parameters, this will print the actual parameter names. This feature helps with frameworks, code analysis, and documentation tools.



增强类型推论功能
========================= Q ===============================
Type Annotations provide the ability to apply an annotation anywhere a type is used, not just on a declaration. Used with a pluggable type system, this feature enables improved type checking of your code.
what does this mean?

This means that, starting with Java 8, you can put annotations directly on any use of a type, not just on class, method, or field declarations. This allows tools (like static analyzers or custom type checkers) to check your code more precisely.

Example:
```java
List<@NonNull String> names;
```

Here, @NonNull is applied to the type argument String, not to the whole field or variable. This helps tools catch errors, such as using null where it’s not allowed.

========================= Q ===============================
Lambda expressions let you express instances of single-method interfaces (referred to as functional interfaces) more compactly.
what does this mean?

This means that, starting with Java 8, you can use lambda expressions to create objects that implement interfaces with a single abstract method (called functional interfaces) using much shorter and simpler code.

========================= Q ===============================
what is  binary compatibility in Java?

Binary compatibility in Java means that compiled Java classes (bytecode) can interact with each other without recompilation, as long as their public APIs have not changed in incompatible ways. If a library or class is updated but remains binary compatible, existing compiled code that uses it will still work without needing to be recompiled. This is important for maintaining compatibility between different versions of libraries and applications.

二进制兼容性
编译过的代码可以和其他代码交互，不需要重新编译，只要public APIs没有变成不兼容的形式。
如果一个库或者类更新了，但是仍然保持二进制兼容性，调用它的代码就不需要重新编译。 这个特性对于维护不同版本的库和应用之间的兼容性很重要。

========================= Q ===============================
Repeating Annotations provide the ability to apply the same annotation type more than once to the same declaration or type use.

what does this mean?

This means that, starting with Java 8, you can use the same annotation multiple times on a single class, method, or other declaration. Previously, you could only use each annotation type once per location.

Example:
```java
@Schedule(day="Monday")
@Schedule(day="Tuesday")
public void process() { }
```
Here, the @Schedule annotation is applied twice to the process method. This is possible because of the repeating annotations feature introduced in Java 8.