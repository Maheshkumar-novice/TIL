/*
The header file #include <bits/stdc++.h> is a non-standard header file commonly used in competitive programming. It is an amalgamation header that includes most of the standard C++ libraries in one file. This is convenient for rapid development and coding contests but is not recommended for general use due to several reasons, such as increased compile times and the potential for including unnecessary libraries.
*/
#include <bits/stdc++.h>
using namespace std;
using namespace std::chrono;

int main()
{
    /*
    For performance,

    ios::sync_with_stdio(0):
        This line disables the synchronization between the C++ standard streams (cin, cout, cerr, etc.) and the C standard streams (stdin, stdout, stderr). By default, cin and cout are synchronized with C's stdio to ensure compatibility and consistency. Disabling this synchronization can make input and output operations faster, as it removes the overhead of ensuring that C++ streams and C streams remain in sync.

    cin.tie(0):
        This line unties cin from cout. By default, cin is tied to cout, which means that cin will automatically flush cout before performing input operations. Untying them can improve performance if you don't need this automatic flushing.
    */
    ios::sync_with_stdio(0);
    cin.tie(0);

    /* `endl` is significantly slower than `\n`, Added the use case below. */
    auto start1 = high_resolution_clock::now();
    for (int i = 0; i < 1000; ++i)
    {
        cout << i << "\n";
    }
    auto end1 = high_resolution_clock::now();
    auto duration1 = duration_cast<microseconds>(end1 - start1).count();

    auto start2 = high_resolution_clock::now();
    for (int i = 0; i < 1000; ++i)
    {
        cout << i << endl;
    }
    auto end2 = high_resolution_clock::now();
    auto duration2 = duration_cast<microseconds>(end2 - start2).count();

    cout << "Time taken (\\n): " << duration1 << " microseconds" << endl;
    cout << "Time taken: (endl)" << duration2 << " microseconds" << endl;

    // Time taken (\n): 330 microseconds
    // Time taken: (endl)11927 microseconds

    // Time taken (\n): 55 microseconds
    // Time taken: (endl)2303 microseconds

    // Time taken (\n): 271 microseconds
    // Time taken: (endl)8343 microseconds

    return 0;
}

/*
ios::sync_with_stdio(0);:

    This line disables the synchronization between the C++ standard streams (cin, cout, cerr, etc.) and the C standard streams (stdin, stdout, stderr). By default, cin and cout are synchronized with C's stdio to ensure compatibility and consistency. Disabling this synchronization can make input and output operations faster, as it removes the overhead of ensuring that C++ streams and C streams remain in sync.

cin.tie(0);:

    This line unties cin from cout. By default, cin is tied to cout, which means that cin will automatically flush cout before performing input operations. Untying them can improve performance if you don't need this automatic flushing.
*/

/*
endl vs \n

When deciding between `endl` and `"\n"` for newlines in C++ output, it's important to understand their differences and use cases. Both are used to insert a newline character into the output stream, but they have different behaviors regarding buffer flushing.

### Key Differences

1. **`endl` (End Line Manipulator)**
   - **Inserts a Newline**: `endl` inserts a newline character (`'\n'`).
   - **Flushes the Buffer**: After inserting the newline, `endl` flushes the output buffer, ensuring that all output is immediately written to the screen or file.
   - **Use Case**: Useful when you need to ensure that the output is flushed right away, which can be important for real-time output or debugging.

   ```cpp
   std::cout << "Hello, World!" << std::endl;  // Inserts newline and flushes the buffer
   ```

2. **`"\n"` (Newline Character)**
   - **Inserts a Newline**: `"\n"` is a newline character and inserts a newline into the output.
   - **Does Not Flush the Buffer**: Using `"\n"` does not flush the buffer, so the output may be held in the buffer and written out later, depending on the buffering strategy.
   - **Use Case**: More efficient when you don't need immediate output flushing and prefer better performance for large amounts of data.

   ```cpp
   std::cout << "Hello, World!" << "\n";  // Inserts newline without flushing the buffer
   ```

### Performance Considerations

- **Efficiency**: Using `"\n"` is generally more efficient because it does not trigger an additional flush operation. Frequent flushing (as done by `endl`) can impact performance, especially in scenarios with large amounts of output.

- **Flushing Overhead**: Frequent use of `endl` can lead to unnecessary performance overhead due to the flushing operation. In scenarios where performance is critical and real-time output is not a concern, `"\n"` is preferred.

### Best Practices

- **Use `"\n"` for Performance**: In most cases, especially when outputting large volumes of data or in performance-critical applications, prefer using `"\n"` to avoid the overhead of frequent buffer flushing.

- **Use `endl` for Immediate Output**: Use `endl` when you need to ensure that output is immediately visible, such as for debugging purposes or in interactive applications where immediate feedback is necessary.

### Example Comparison

```cpp
#include <iostream>
#include <chrono>

int main() {
    using namespace std::chrono;

    // Timing with "\n"
    auto start1 = high_resolution_clock::now();

    for (int i = 0; i < 100000; ++i) {
        std::cout << i << "\n";  // Newline without flushing
    }

    auto end1 = high_resolution_clock::now();
    auto duration1 = duration_cast<microseconds>(end1 - start1).count();
    std::cout << "Time taken with '\\n': " << duration1 << " microseconds" << std::endl;

    // Timing with endl
    auto start2 = high_resolution_clock::now();

    for (int i = 0; i < 100000; ++i) {
        std::cout << i << std::endl;  // Newline with flushing
    }

    auto end2 = high_resolution_clock::now();
    auto duration2 = duration_cast<microseconds>(end2 - start2).count();
    std::cout << "Time taken with 'endl': " << duration2 << " microseconds" << std::endl;

    return 0;
}
```

In the above example, you will likely see that using `"\n"` is faster than using `endl` due to the reduced flushing overhead.

### Summary

- **`"\n"`**: More efficient for performance due to lack of buffering flush; use it when immediate output is not critical.
- **`endl`**: Ensures immediate output due to flushing; use it when you need to make sure the output is immediately visible or for debugging.

Choosing between `endl` and `"\n"` depends on the specific requirements of your application regarding performance and output immediacy.

*/
