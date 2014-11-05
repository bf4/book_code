class Book:
    ... Other definitions as before ...

    def __str__(self):
        """ (Book) -> str

        Return a human-readable string representation of this Book.
        """

        return """Title: {0}
Authors: {1}
Publisher: {2}
ISBN: {3}""".format(
    self.title, ', '.join(self.authors), self.publisher, self.ISBN)

if __name__ == '__main__':
    pybook = Book("Practical Programming",
        ["Campbell", "Gries", "Montojo"],
        "Pragmatic Bookshelf",
        "978-1-93778-545-1")
    print(pybook)
