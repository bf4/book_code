>>> import read_smallest
>>> read_smallest.smallest_value(open('hebron.txt', 'r'))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "./read_smallest.py", line 19, in smallest_value
    value = int(line.strip())
ValueError: invalid literal for int() with base 10: '-'
