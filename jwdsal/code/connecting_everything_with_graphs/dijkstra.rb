#---
# Excerpted from "A Common-Sense Guide to Data Structures and Algorithms",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jwdsal for more book information.
#---
class City
  
  attr_accessor :name, :routes

  def initialize(name)
    @name = name
    # For the adjacent nodes, we are now using a hash table
    # instead of an array:
    @routes = {}
    # As as an example, if this were Atlanta, its routes would be:
    # {boston => 100, denver => 160}
  end

  def add_route(city, price_info)
    @routes[city] = price_info
  end
  
end

atlanta = City.new("Atlanta")
boston = City.new("Boston")
chicago = City.new("Chicago")
denver = City.new("Denver")
el_paso = City.new("El Paso")

atlanta.add_route(boston, 100)
atlanta.add_route(denver, 160)
boston.add_route(chicago, 120)
boston.add_route(denver, 180)
chicago.add_route(el_paso, 80)
denver.add_route(chicago, 40)
denver.add_route(el_paso, 140)

def dijkstra(starting_city, other_cities)
  # The routes_from_city hash table below holds the data of all price_infos
  # from the given city to all other destinations, and the city which it
  # took to get there:
  routes_from_city = {}
  # The format of this data is:
  # {city => [price, other city which immediately precedes this city
  # along the path from the original city]}

  # In our example this will end up being:
  # {atlanta => [0, nil], boston => [100, atlanta], chicago => [200, denver],
  # denver => [160, atlanta], el_paso => [280, chicago]}

  # Since it costs nothing to get to the starting city from the starting city:
  routes_from_city[starting_city] = [0, starting_city]
  
  # When initializing our data, we set up all other cities having an 
  # infinite cost - since the cost and the path to get to each other city
  # is currently unknown:
  other_cities.each do |city|
    routes_from_city[city] = [Float::INFINITY, nil]
  end
  # In our example, our data starts out as:
  # {atlanta => [0, nil], boston => [Float::INFINITY, nil], 
  # chicago => [Float::INFINITY, nil], 
  # denver => [Float::INFINITY, nil], el_paso => [Float::INFINITY, nil]}
  
  # We keep track of which cities we visited in this array:
  visited_cities = []

  # We begin visiting the starting city by making it the current_city:
  current_city = starting_city

  # We launch the heart of the algorithm, which is a loop that visits
  # each city:
  while current_city

    # We officially visit the current city:
    visited_cities << current_city

    # We check each route from the current city:
    current_city.routes.each do |city, price_info|
      # If the route from the starting city to the other city
      # is cheaper than currently recorded in routes_from_city, we update it:
      if routes_from_city[city][0] > price_info + routes_from_city[current_city][0]
        routes_from_city[city] = [price_info + routes_from_city[current_city][0], current_city]
      end
    end

    # We determine which city to visit next:
    current_city = nil
    cheapest_route_from_current_city = Float::INFINITY
    # We check all available routes:
    routes_from_city.each do |city, price_info|
    # if this route is the cheapest from this city, and it has not yet been
    # visited yet, it should be marked as the city we'll visit next:
      if price_info[0] < cheapest_route_from_current_city && !visited_cities.include?(city)
        cheapest_route_from_current_city = price_info[0]
        current_city = city
      end
    end
    
  end

  return routes_from_city
end

routes = dijkstra(atlanta, [boston, chicago, denver, el_paso])
routes.each do |city, price_info|
  p "#{city.name}: #{price_info[0]}"
end