import time
import random
from sorts import selection_sort
from sorts import insertion_sort
from sorts import mergesort


def built_in(L):
    """ (list) -> NoneType
    Call list.sort --- we need our own function to do this so that we can
    treat it as we treat our own sorts."""

    L.sort()


def print_times(L):
    """ (list) -> NoneType

    Print the number of milliseconds it takes for selection sort, insertion
    sort, and list.sort to run.
    """

    print(len(L), end='\t')
    for func in (selection_sort, insertion_sort, mergesort, built_in):
        if func in (selection_sort, insertion_sort) and len(L) > 10000:
            continue

        L_copy = L[:]
        t1 = time.perf_counter()
        func(L_copy)
        t2 = time.perf_counter()
        print("{0:7.1f}".format((t2 - t1) * 1000.), end='\t')
    print()  # Print a newline.

for list_size in [10, 1000, 2000, 3000, 4000, 5000, 10000]:
    L = list(range(list_size))
    random.shuffle(L)
    print_times(L)
