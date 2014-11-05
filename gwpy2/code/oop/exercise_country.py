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

    def population_density(self):
        """ (Country) -> number

        Return the population density in people per sq km for this
        country.
        """

        return self.population / self.area

    def __str__(self):
        """ (Country) -> str

        Return a string representation of this country.
        """

        return '{0} has population {1} and is {2} square km.'.format(
            self.name, self.population, self.area)

if __name__ == '__main__':

    canada = Country('Canada', 34482779, 9984670)
    print(canada.name)
    print(canada.population)
    print(canada.area)

    canada = Country('Canada', 34482779, 9984670)
    usa = Country('United States of America', 313914040, 9826675)
    is_larger(canada, usa)

    print(usa)


