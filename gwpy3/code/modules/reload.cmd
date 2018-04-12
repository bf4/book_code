>>> import example
>>> example.x
2
>>> example.x = 7
>>> example.x
7
>>> import importlib
>>> example = importlib.reload(example)
>>> example.x
2