======================================================================
FAIL: test_running_sum_one_item (__main__.TestRunningSum)
Test a one-item list.
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/Users/campbell/pybook/gwpy2/Book/code/testdebug/test_running_sum.
  py", line 21, in test_running_sum_one_item
    self.assertEqual(expected, argument, "The list contains one item.")
AssertionError: Lists differ: [5] != [10]
First differing element 0:
5
10

- [5]
+ [10] : The list contains one item.