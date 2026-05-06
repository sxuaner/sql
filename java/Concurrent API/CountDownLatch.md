// ...existing code...

# CountDownLatch

Package: `java.util.concurrent`  
Class: `java.util.concurrent.CountDownLatch`

A synchronization aid that allows one or more threads to wait until a set of operations performed in other threads completes. Initialized with a count; `await()` blocks until the count reaches zero due to calls to `countDown()`. The latch is one-shot (cannot be reset). For resettable behavior use `CyclicBarrier`.

## Key points
- Construct with a non-negative count: `new CountDownLatch(int count)`.
- `countDown()` decrements the count; when it reaches zero all waiting threads are released.
- `await()` blocks until the count reaches zero (or the thread is interrupted / timeout elapses).
- `getCount()` returns the current count (useful for debugging).
- `toString()` returns a short identifying string including the count (e.g., "Count = n").
- Memory consistency: actions before a thread calls `countDown()` happen-before actions after a successful return from a corresponding `await()` in another thread.

## Sample usage

```java
CountDownLatch startSignal = new CountDownLatch(1);
CountDownLatch doneSignal  = new CountDownLatch(N);

for (int i = 0; i < N; ++i)
    new Thread(new Worker(startSignal, doneSignal)).start();

doSomethingElse();
startSignal.countDown(); // let all workers proceed
doneSignal.await();      // wait for all to finish
```

Worker example:

```java
class Worker implements Runnable {
  private final CountDownLatch startSignal;
  private final CountDownLatch doneSignal;
  Worker(CountDownLatch startSignal, CountDownLatch doneSignal) {
    this.startSignal = startSignal;
    this.doneSignal = doneSignal;
  }
  public void run() {
    try {
      startSignal.await();
      doWork();
      doneSignal.countDown();
    } catch (InterruptedException ex) { /* handle */ }
  }
  void doWork() { ... }
}
```

## Constructors
- `CountDownLatch(int count)` — construct with the given count. Throws `IllegalArgumentException` if `count < 0`.

## Methods (summary)
- `void await() throws InterruptedException`  
  Wait until count reaches zero or thread is interrupted.

- `boolean await(long timeout, TimeUnit unit) throws InterruptedException`  
  Wait up to the given timeout, returning `true` if the count reached zero, otherwise `false`.

- `void countDown()`  
  Decrement the count if greater than zero; if new count is zero, release all waiting threads.

- `long getCount()`  
  Return the current count (mainly for debugging/testing).

- `String toString()`  
  Return identifying string including current count (e.g., "Count = n").

## Notes
- A `CountDownLatch` does not require callers of `countDown()` to wait; it only blocks callers of `await()` until the count is zero.
- For repeated barriers use `CyclicBarrier` instead.

 //