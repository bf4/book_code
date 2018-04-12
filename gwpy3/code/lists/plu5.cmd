>>> half_lives = [87.74, 24110.0, 6537.0, 14.4, 376000.0]
>>> i = 2
>>> i < len(half_lives)
True

>>> half_lives[i]
6537.0
>>> j = 5
>>> j < len(half_lives)
False
>>> half_lives[j]
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
IndexError: list index out of range
