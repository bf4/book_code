class Book:
    """…"""

    def __init__(self, title, authors, publisher, isbn):
        """…"""

        self.title = title
        # Copy the list in case the caller modifies that list later.
        self.authors = authors[:]
        self.publisher = publisher
        self.ISBN = isbn

    def num_authors(self):
        """…"""

        return len(self.authors)


if __name__ == '__main__':
    pybook = Book("Practical Programming",
        ["Campbell", "Gries", "Montojo"],
        "Pragmatic Bookshelf",
        "978-1-93778-545-1")
    pybook.num_authors()
