class Book:
    """Information about a book, including title, list of authors,
    publisher, and ISBN.
    """

    def num_authors(self):
        """ (Book) -> int

        Return the number of authors of this book.

        >>> pybook = Book()
        >>> pybook.authors = ["Campbell", "Gries", "Montojo"]
        >>> pybook.num_authors()
        3
        """

        return len(self.authors)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
