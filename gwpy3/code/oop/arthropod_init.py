class Arthropod(Organism):
    """An arthropod that has a fixed number of legs."""

    def __init__(self, name, x, y, legs):
        """ (Arthropod, str, int, int, int) -> NoneType

        An arthropod with the given number of legs that exists at location
        (x, y) in the tide pool.
        """

        Organism.__init__(self, name, x, y)
        self.legs = legs
