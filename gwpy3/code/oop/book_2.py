class Book:
    """Information about a book."""

    def num_authors(self) -> int:
        """Return the number of authors of this book.
        """

        return len(self.authors)
