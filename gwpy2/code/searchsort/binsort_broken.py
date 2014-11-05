import bisect

def bin_sort(values):
    """Sort values in place.  THIS VERSION IS FLAWED"""
    for i in range(1, len(values)):
        bisect.insort_left(values, values[i], 0, i)
