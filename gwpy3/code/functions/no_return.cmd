>>> def f(x):
...     x = 2 * x
...
>>> res = f(3)
>>> res
>>>
>>> print(res)
None
>>> id(res)
1756120
>>> type(res)
<class 'NoneType'>
>>> def f(x):
...     x = 2 * x
...     return None
...
>>> print(f(3))
None
>>> def print_intro(name):
...     """ (str) -> NoneType
...     Print a personalized greeting using name.
...     >>> print_intro('Jason')
...     Hello, Jason.
...     """
...     print('Hello,', name, end='.\n')
...
>>> print_intro('Jen')
Hello, Jen.
