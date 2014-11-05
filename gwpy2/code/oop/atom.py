class Atom:
    """ An atom with a number, symbol, and coordinates. """

    def __init__(self, num, sym, x, y, z):
        """ (Atom, int, str, number, number, number) -> NoneType

        Create an Atom with number num, string symbol sym, and float
        coordinates (x, y, z).
        """

        self.number = num
        self.center = (x, y, z)
        self.symbol = sym

    def translate(self, x, y, z):
        """ (Atom, number, number, number) -> NoneType

        Move this Atom by adding (x, y, z) to its coordinates.
        """

        self.center = (self.center[0] + x,
                       self.center[1] + y,
                       self.center[2] + z)

    def __str__(self):
        """ (Atom) -> str

        Return a string representation of this Atom in this format:

            (SYMBOL, X, Y, Z)
        """

        return '({0}, {1}, {2}, {3})'.format(
            self.symbol, self.center[0], self.center[1], self.center[2])

    def __repr__(self):
        """ (Atom) -> str

        Return a string representation of this Atom in this format:

            Atom(NUMBER, "SYMBOL", X, Y, Z)
        """

        return 'Atom({0}, "{1}", {2}, {3}, {4})'.format(
            self.number, self.symbol,
            self.center[0], self.center[1], self.center[2])

if __name__ == '__main__':
    nitrogen = Atom(1, "N", 0.257, -0.363, 0.0)
    nitrogen.translate(0, 0, 0.2)
