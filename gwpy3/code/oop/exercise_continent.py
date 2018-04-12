import exercise_country as country

class Continent:

    def __init__(self, name, countries):
        """ (Continent, str, list of Country) -> NoneType

        Initialize this Continent named named with countries.
        """

        self.name = name
        self.countries = countries


    def total_population(self):
        """ (Continent) -> int

        Return the population of this continent.
        """

        pop = 0
        for country in self.countries:
            pop += country.population

        return pop

    def __str__(self):
        """ (Continent) -> str

        Return a string representation of this continent.
        """

        result = self.name
        for country in countries:
            result += '\n' + str(country)

        return result
            
            

    
