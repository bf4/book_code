>>> python_book_1 = book.Book(
...     'Practical Programming', ['Campbell', 'Gries', 'Montojo'],
...     'Pragmatic Bookshelf', '978-1-93778-545-1', 25.0)
>>> python_book_2 = book.Book(
...     'Practical Programming', ['Campbell', 'Gries', 'Montojo'],
...     'Pragmatic Bookshelf', '978-1-93778-545-1', 25.0)
>>> survival_book = book.Book(
...     "New Programmer's Survival Manual", ['Carter'],
...     'Pragmatic Bookshelf', '978-1-93435-681-4', 19.0)
>>> python_book_1 == python_book_2
True
>>> python_book_1 == survival_book
False
