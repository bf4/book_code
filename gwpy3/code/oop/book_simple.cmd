>>> class Book:
...     """Information about a book."""
...
>>> type(str)
<class 'type'>
>>> type(Book)
<class 'type'>
>>> dir(Book)
['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__',
'__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__',
'__init_subclass__', '__le__', '__lt__', '__module__', '__ne__', '__new__',
'__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__',
'__str__', '__subclasshook__', '__weakref__']
>>> set(dir(Book)) - set(dir(object))
{'__module__', '__weakref__', '__dict__'}
>>> b = Book()
>>> type(b)
<class '__main__.Book'>
>>> b
<__main__.Book object at 0x58a550>
>>> help(Book)
Help on class Book in module __main__:

class Book(builtins.object)
 |  Information about a book.
 |
 |  Data descriptors defined here:
 |
 |  __dict__
 |      dictionary for instance variables (if defined)
 |
 |  __weakref__
 |      list of weak references to the object (if defined)
>>> pybook.title = "Practical Programming"
>>> pybook.authors = ["Campbell", "Gries", "Montojo"]
>>> pybook.publisher = "Pragmatic Bookshelf"
>>> pybook.ISBN = "978-1-6805026-8-8"
>>> pybook.title
'Practical Programming'
>>> pybook.authors
['Campbell', 'Gries', 'Montojo']
>>> pybook.publisher
'Pragmatic Bookshelf'
>>> pybook.ISBN
'978-1-6805026-8-8'
>>> pybook
<__main__.Book object at 0x586ff0>
