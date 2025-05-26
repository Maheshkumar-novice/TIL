for deleting the list items based on conditions.

```python
def remove_if(lst, condition):
    for i in reversed(range(len(lst))):
        if not condition(lst[i]):
            del lst[i]
numbers = [1, 2, 3, 4, 5, 6]
remove_if(numbers, lambda x: x % 2 == 0)
print(numbers)  # Output: [2, 4, 6]
```

we can also use list comprehension. but that will use more memory but faster in big lists.

```python
import random
import timeit

# --- Helper functions for benchmarking ---
# These are defined at the module level so timeit can easily access them.

def del_method_for_benchmark(data_list):
    """
    Performs deletion using 'del' on a copy of the list.
    Iterates backwards to correctly handle index changes.
    """
    list_copy = list(data_list) # Work on a copy
    # Iterate backwards when deleting to avoid index shifting issues.
    for i in range(len(list_copy) - 1, -1, -1):
        # Random condition: 30% chance to remove the element
        if random.random() < 0.3:
            del list_copy[i]
    return list_copy

def comprehension_method_for_benchmark(data_list):
    """
    Filters list using list comprehension based on a random condition.
    Creates a new list.
    """
    # The random condition is evaluated for each item.
    # Keep if condition for removal (30% chance) is FALSE (i.e., random.random() >= 0.3)
    new_list = [item for item in data_list if not (random.random() < 0.3)]
    return new_list

def demonstrate_list_operations():
    """
    Demonstrates generating a list with random numbers and removing
    elements using `del` and list comprehension based on random conditions.
    This part is for logical demonstration on a small scale.
    """
    print("--- Logical Demonstration ---")
    # Generate a small list for demonstration
    original_list = [random.randint(1, 100) for _ in range(15)]
    print(f"Original list (size 15): \n{original_list}\n")

    # --- `del` operation demonstration ---
    list_for_del_op_demo = list(original_list) # Work on a copy
    print(f"List before 'del' demonstration: \n{list_for_del_op_demo}")
    # Iterate backwards for the `del` demonstration
    indices_removed_demo = []
    for i in range(len(list_for_del_op_demo) - 1, -1, -1):
        if random.random() < 0.3:  # 30% chance to remove
            # print(f"  - Demo 'del': Removing element {list_for_del_op_demo[i]} at original index (relative to current list state)")
            indices_removed_demo.append(list_for_del_op_demo[i])
            del list_for_del_op_demo[i]
    if indices_removed_demo:
        print(f"  - Demo 'del': Elements considered for removal (if condition met): {indices_removed_demo[::-1]}")
    print(f"List after 'del' demonstration: \n{list_for_del_op_demo}\n")


    # --- List comprehension demonstration ---
    print(f"Original list (for comprehension demo): \n{original_list}")
    # "Remove" by not including if random.random() < 0.3
    print("Evaluating elements for list comprehension demonstration:")
    list_after_comp_demo = [
        item for item in original_list 
        if not (random.random() < 0.3) 
    ]
    # To show which items might have been "excluded" is harder without iterating twice
    # or storing the random numbers. The main point is the resulting list.
    print(f"List after list comprehension demonstration (new list created): \n{list_after_comp_demo}\n")


def run_performance_benchmark():
    """
    Benchmarks the 'del' vs list comprehension methods using timeit.
    """
    print("\n--- Performance Benchmark ---")
    list_size = 10 # Use a larger list for benchmarking
    number_of_runs = 100000000  # Number of times to execute the statement for timeit

    # Generate a sample list for benchmarking
    # This list will be passed to the functions being timed.
    benchmark_data_list = [random.randint(1, 100) for _ in range(list_size)]
    print(f"Benchmarking with list size: {list_size}, timeit repetitions: {number_of_runs}\n")

    # Time the 'del' method
    # The `globals` dict makes our functions and data available to timeit
    # It's important that `random` is also available in the timeit execution scope
    time_del = timeit.timeit(
        stmt='del_method_for_benchmark(benchmark_data_list)',
        globals={
            'del_method_for_benchmark': del_method_for_benchmark,
            'benchmark_data_list': benchmark_data_list,
            'random': random  # Ensure random module is in timeit's scope
        },
        number=number_of_runs
    )
    print(f"Time for 'del' method: {time_del:.6f} seconds")

    # Time the list comprehension method
    time_comprehension = timeit.timeit(
        stmt='comprehension_method_for_benchmark(benchmark_data_list)',
        globals={
            'comprehension_method_for_benchmark': comprehension_method_for_benchmark,
            'benchmark_data_list': benchmark_data_list,
            'random': random # Ensure random module is in timeit's scope
        },
        number=number_of_runs
    )
    print(f"Time for list comprehension method: {time_comprehension:.6f} seconds")

    # Compare results
    if time_comprehension < time_del:
        diff = time_del - time_comprehension
        percentage_faster = (diff / time_del) * 100 if time_del > 0 else float('inf')
        print(f"\nList comprehension was FASTER by {diff:.6f} seconds ({percentage_faster:.2f}%).")
    elif time_del < time_comprehension:
        diff = time_comprehension - time_del
        percentage_faster = (diff / time_comprehension) * 100 if time_comprehension > 0 else float('inf')
        print(f"\n'del' method was FASTER by {diff:.6f} seconds ({percentage_faster:.2f}%).")
    else:
        print("\nBoth methods took approximately the same time.")
    
    print("Note: `random.random()` calls are part of the timed operations, reflecting dynamic conditions.")


if __name__ == "__main__":
    demonstrate_list_operations()
    run_performance_benchmark()
```
