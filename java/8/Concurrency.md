Classes and interfaces have been added to the java.util.concurrent package.

Methods have been added to the java.util.concurrent.ConcurrentHashMap class to support aggregate operations based on the newly added streams facility and lambda expressions.



Classes have been added to the java.util.concurrent.atomic package to support scalable updatable variables.

In Java 8, scalable updatable variables refer to new classes added to the java.util.concurrent.atomic package, such as LongAdder and DoubleAdder. These classes provide thread-safe variables that scale better under high contention than traditional atomic variables like AtomicLong. They allow multiple threads to update values efficiently, improving performance in concurrent applications.