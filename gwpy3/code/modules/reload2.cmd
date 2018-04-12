>>> import math
>>> math.pi
3.141592653589793
>>> math.pi = 3
>>> math.pi
3
>>> math = importlib.reload(math)
>>> math.pi
3