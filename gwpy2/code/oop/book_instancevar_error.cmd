>>> import book
>>> book.Book.title
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: type object 'Book' has no attribute 'title'
>>> dir(book.Book)
['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__',
[''__format__', '__ge__', '__getattribute__', '__gt__', '__hash__',
[''__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__',
[''__qualname__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__',
[''__sizeof__', '__str__', '__subclasshook__', '__weakref__', 'num_authors']
>>> python_book = book.Book(
...         'Practical Programming',
...         ['Campbell', 'Gries', 'Montojo'],
...         'Pragmatic Bookshelf',
...         '978-1-93778-545-1',
...         25.0)
>>> dir(python_book)
['ISBN', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__',
[''__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__',
[''__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__',
[''__qualname__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__',
[''__sizeof__', '__str__', '__subclasshook__', '__weakref__', 'authors',
[''num_authors', 'price', 'publisher', 'title']
