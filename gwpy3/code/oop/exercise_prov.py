class Country:
    """ A country with a name, population, and area. """

    def __init__(self, name, pop, area):
        """ (Country, str, int, int) -> NoneType

        Initialize this Country named name with population pop and 
        area square kilometers.
        """

        self.name = name
        self.population = pop
        self.area = area

    def is_larger(self, other):
        """ (Country, Country) -> NoneType

        Return True if and only if this country has a larger area
        than other.
        """

        return self.area > other.area

    def __str__(self):
        """ (Country) -> str

        Return a string representation of this country.
        """

