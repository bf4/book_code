def selection_sort(L):
    """ (list) -> NoneType
	
    Reorder the items in L from smallest to largest.
	
    >>> L = [3, 4, 7, -1, 2, 5]
    >>> selection_sort(L)
    >>> L
    [-1, 2, 3, 4, 5, 7]
    """

    i = 0
    while i != len(L):
        # Find the index of the smallest item in L[i:]
        # Swap that smallest item with L[i]
        i = i + 1
