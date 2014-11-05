import time
import binary_search


def time_it(search, L, v):
    """ (function, object, list) -> number

    Time how long it takes to run function search to find
    value v in list L.
    """

    t1 = time.perf_counter()
    search(L, v)
    t2 = time.perf_counter()

    return (t2 - t1) * 1000.0


def print_times(v, L):
    """ (object, list) -> NoneType

    Print the number of milliseconds it takes for linear_search(v, L)
    to run for list.index, the while loop linear search, the for loop
    linear search, and sentinel search.
    """

    # Get list.index's running time.
    t1 = time.perf_counter()
    L.index(v)
    t2 = time.perf_counter()
    index_time = (t2 - t1) * 1000.0

    # Get the other three running times.
    binary_time = time_it(binary_search.binary_search, L, v)

    print("{0}\t{1:.4f}\t{2:.4f}\t{3:.2f}".format(
            v, index_time, binary_time, index_time / binary_time))

L = list(range(10000001))  # A list with just over ten million values

print_times(10, L)  # How fast is it to search near the beginning?
print_times(5000000, L)  # How fast is it to search near the middle?
print_times(10000000, L)  # How fast is it to search near the end?
