class Book:
    ...other definitions as before...

    def __eq__(self, other):
        """This is a bad way to define this method."""

        self.ISBN = other.ISBN
        return self.ISBN == other.ISBN
