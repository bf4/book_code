

def find_min(L, b):
    """ (list, int) -> int

    Precondition: L[b:] is not empty.

    Return the index of the smallest value in L[b:].

    >>> find_min([3, -1, 7, 5], 0)
    1
    >>> find_min([3, -1, 7, 5], 1)
    1
    >>> find_min([3, -1, 7, 5], 2)
    3
    """

    smallest = b  # The index of the smallest so far.
    i = b + 1
    while i != len(L):
        if L[i] < L[smallest]:
            # We found a smaller item at L[i].
            smallest = i

        i = i + 1

    return smallest


def selection_sort(L):
    """ (list) -> NoneType
	
    Reorder the items in L from smallest to largest.
	
    >>> L = [3, 4, 7, -1, 2, 5]
    >>> selection_sort(L)
    >>> L
    [-1, 2, 3, 4, 5, 7]
    >>> L = []
    >>> selection_sort(L)
    >>> L
    []
    >>> L = [1]
    >>> selection_sort(L)
    >>> L
    [1]
    >>> L = [2, 1]
    >>> selection_sort(L)
    >>> L
    [1, 2]
    >>> L = [1, 2]
    >>> selection_sort(L)
    >>> L
    [1, 2]
    >>> L = [3, 3, 3]
    >>> selection_sort(L)
    >>> L
    [3, 3, 3]
    >>> L = [-5, 3, 0, 3, -6, 2, 1, 1]
    >>> selection_sort(L)
    >>> L
    [-6, -5, 0, 1, 1, 2, 3, 3]
    """
	
    i = 0
	
    while i != len(L):
        smallest = find_min(L, i)
        L[i], L[smallest] = L[smallest], L[i]
        i = i + 1

if __name__ == '__main__':
    import doctest
    doctest.testmod()


# from sort4 import selection_sort
# import unittest


# class TestSelectionSort(unittest.TestCase):

#     def test_empty(self):
#         '''Test sorting empty list.'''

#         L = []
#         expected = []
#         selection_sort(L)
#         self.assertEqual(expected, L,
#             "Expected {0} but saw {1}".format(expected, L))

#     def test_one(self):
#         '''Test sorting a list of one value.'''

#         L = [1]
#         expected = [1]
#         selection_sort(L)
#         self.assertEqual(expected, L,
#             "Expected {0} but saw {1}".format(expected, L))

#     def test_two_ordered(self):
#         '''Test sorting an already-sorted list of two values.'''

#         L = [1, 2]
#         expected = [1, 2]
#         selection_sort(L)
#         self.assertEqual(expected, L,
#             "Expected {0} but saw {1}".format(expected, L))

#     def test_two_reversed(self):
#         '''Test sorting a reverse-ordered list of two values.'''

#         L = [2, 1]
#         expected = [1, 2]
#         selection_sort(L)
#         self.assertEqual(expected, L,
#             "Expected {0} but saw {1}".format(expected, L))

#     def test_three_identical(self):
#         '''Test sorting a list of three equal values.'''

#         L = [3, 3, 3]
#         expected = [3, 3, 3]
#         selection_sort(L)
#         self.assertEqual(expected, L,
#             "Expected {0} but saw {1}".format(expected, L))

#     def test_three_split(self):
#         '''Test sorting a list with one number different.'''

#         L = [3, 0, 3]
#         expected = [0, 3, 3]
#         selection_sort(L)
#         self.assertEqual(expected, L,
#             "Expected {0} but saw {1}".format(expected, L))

#     def test_several(self):
#         '''Test sorting a list with several values, some duplicated.'''

#         L = [-5, 3, 0, 3, -6, 2, 1, 1]
#         expected = [-6, -5, 0, 1, 1, 2, 3, 3]
#         selection_sort(L)
#         self.assertEqual(expected, L,
#             "Expected {0} but saw {1}".format(expected, L))

# if __name__ == '__main__':
#     unittest.main()
