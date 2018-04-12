from typing import List

class Book:
    """Information about a book, including title, list of authors,
    publisher, ISBN, and price.
    """

    def __init__(self, title: str, authors: List[str], publisher: str,
                 isbn: str, price: float) -> None:
        """Create a new book entitled title, written by the people in authors,
        published by publisher, with ISBN isbn and costing price dollars.

        >>> python_book = Book( \
                'Practical Programming', \
                ['Campbell', 'Gries', 'Montojo'], \
                'Pragmatic Bookshelf', \
                '978-1-6805026-8-8', \
                25.0)
        >>> python_book.title
        'Practical Programming'
        >>> python_book.authors
        ['Campbell', 'Gries', 'Montojo']
        >>> python_book.publisher
        'Pragmatic Bookshelf'
        >>> python_book.ISBN
        '978-1-6805026-8-8'
        >>> python_book.price
        25.0
        """

        self.title = title
        # Copy the list in case the caller modifies that list later.
        self.authors = authors[:]
        self.publisher = publisher
        self.ISBN = isbn
        self.price = price

    def num_authors(self):
        """ (Book) -> int

        Return the number of authors of this book.

        >>> pybook = Book("Practical Programming", \
            ["Campbell", "Gries", "Montojo"], \
            "Pragmatic Bookshelf", \
            "978-1-6805026-8-8")
        >>> pybook.num_authors()
        3
        """

        return len(self.authors)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
