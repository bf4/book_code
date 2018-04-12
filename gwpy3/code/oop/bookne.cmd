>>> python_book_1 = book.Book(
...     'Practical Programming',
...     ['Campbell', 'Gries', 'Montojo'],
...     'Pragmatic Bookshelf',
...     '978-1-6805026-8-8',
...     25.0)
>>> python_book_2 = book.Book(
...     'Practical Programming',
...     ['Campbell', 'Gries', 'Montojo'],
...     'Pragmatic Bookshelf',
...     '978-1-6805026-8-8',
...     25.0)
>>> python_book_1 == python_book_2
False
>>> python_book_1 == python_book_1
True
>>> python_book_2 == python_book_2
True
