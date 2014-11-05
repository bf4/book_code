>>> def is_positive(x):
...     """ (number) -> bool
... 
...     Return True iff x is positive.
... 
...     >>> is_positive(3)
...     True

...     >>> is_positive(-4.6)
...     False
...     """
...     return x > 0
... 
>>> is_positive(3)
True
>>> is_positive(-4.6)
False
>>> is_positive(0)
False
