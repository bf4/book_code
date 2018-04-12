>>> from binsort_broken import bin_sort
>>> tests = [ [], [1], [1, 2], [2, 1] ]
>>> for t in tests:
...     print t, '->',
...     bin_sort(t)
...     print t
... 
[] -> []
[1] -> [1]
[1, 2] -> [1, 2, 2]
[2, 1] -> [1, 2, 1]
