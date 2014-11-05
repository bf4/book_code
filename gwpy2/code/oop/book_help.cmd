>>> help(Book)
Help on class Book in module book:

class Book(builtins.object)
 |  Information about a book, including title, list of authors,
 |  publisher, and ISBN.
 |
 |  Methods defined here:
 |
 |  __eq__(self, other)
 |      (Book, Book) -> bool
 |
 |      Return True iff this book and other have the same ISBN.
 |
 |  __init__(self, title, authors, publisher, isbn)
 |      (Book, str, list of str, str, str) -> NoneType
 |
 |      Create a new book entitled title, written by the people in authors,
 |      published by publisher, with ISBN isbn.  Make a copy of the
 |      authors list to avoid aliasing.
 |
 |  __str__(self)
 |      (Book) -> str
 |
 |      Return a human-readable string representation of this Book.
 |
 |  num_authors(self)
 |      (Book) -> int
 |
 |      Return the number of authors of this book.
 |
 |      >>> pybook = Book("Practical Programming",
              ["Campbell", "Gries", "Montojo"],
              "Pragmatic Bookshelf",
              "978-1-93778-545-1")
 |      >>> pybook.num_authors()
 |      3
 |
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |
 |  __dict__
 |      dictionary for instance variables (if defined)
 |
 |  __weakref__
 |      list of weak references to the object (if defined)
 |
 |  ----------------------------------------------------------------------
 |  Data and other attributes defined here:
 |
 |  __hash__ = None
