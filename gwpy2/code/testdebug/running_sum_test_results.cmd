..FF.FF
======================================================================
FAIL: test_running_sum_multi_negative (__main__.TestRunningSum)
Test a list of negative values.
----------------------------------------------------------------------
Traceback (most recent call last):
  File "test_running_sum.py", line 39, in test_running_sum_multi_negative
    "The list contains only negative values.")
AssertionError: Lists differ: [-1, -6, -9, -13] != [-5, -10, -13, -17]

First differing element 0:
-1
-5

- [-1, -6, -9, -13]
+ [-5, -10, -13, -17] : The list contains only negative values.

======================================================================
FAIL: test_running_sum_multi_positive (__main__.TestRunningSum)
Test a list of positive values.
----------------------------------------------------------------------
Traceback (most recent call last):
  File "test_running_sum.py", line 56, in test_running_sum_multi_positive
    "The list contains only positive values.")
AssertionError: Lists differ: [4, 6, 9, 15] != [10, 12, 15, 21]

First differing element 0:
4
10

- [4, 6, 9, 15]
+ [10, 12, 15, 21] : The list contains only positive values.

======================================================================
FAIL: test_running_sum_one_item (__main__.TestRunningSum)
Test a one-item list.
----------------------------------------------------------------------
Traceback (most recent call last):
  File "test_running_sum.py", line 22, in test_running_sum_one_item
    self.assertEqual(expected, argument, "The list contains one item.")
AssertionError: Lists differ: [5] != [10]

First differing element 0:
5
10

- [5]
+ [10] : The list contains one item.

======================================================================
FAIL: test_running_sum_two_items (__main__.TestRunningSum)
Test a two-item list.
----------------------------------------------------------------------
Traceback (most recent call last):
  File "test_running_sum.py", line 30, in test_running_sum_two_items
    self.assertEqual(expected, argument, "The list contains two items.")
AssertionError: Lists differ: [2, 7] != [7, 12]

First differing element 0:
2
7

- [2, 7]
+ [7, 12] : The list contains two items.

----------------------------------------------------------------------
Ran 7 tests in 0.002s

FAILED (failures=4)
