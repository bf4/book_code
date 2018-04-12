class Arthropod(Organism):
    """An arthropod that has a fixed number of legs."""

    def __init__(self, name, x, y, legs):
        """ An arthropod with the given number of legs that exists at location
        (x, y) in the tide pool."""

        Organism.__init__(self, name, x, y)
        self.legs = legs

    def __str__(self):
        """ (Arthropod) -> str

        Return a string representation of this Arthropod.
        """

        return '(%s, %s, [%s, %s])' % (self.name, self.legs, self.x, self.y)
