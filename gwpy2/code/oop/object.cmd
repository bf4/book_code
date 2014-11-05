>>> isinstance('abc', str)
True
>>> isinstance(55.2, str)
False
Help on built-in function isinstance in module builtins:

isinstance(...)
    isinstance(object, class-or-type-or-tuple) -> bool

    Return whether an object is an instance of a class or of a subclass thereof.
    With a type as second argument, return whether that is the object's type.
    The form using a tuple, isinstance(x, (A, B, ...)), is a shortcut for
>>> help(object)
Help on class object in module builtins:

class object
 |  The most base type
>>> isinstance(55.2, object)
True
>>> isinstance('abc', object)
True
>>> isinstance(str, object)
True
>>> isinstance(max, object)
True
>>> dir(object)
['__class__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__',
'__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__',
'__lt__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__',
'__setattr__', '__sizeof__', '__str__', '__subclasshook__']
