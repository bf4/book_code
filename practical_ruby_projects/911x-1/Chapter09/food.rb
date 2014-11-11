require 'rubygems'
require 'rparsec'

include Parsers

Space = string(" ")
With = string("with")
On = string("on")

Swiss = string("Swiss")
Cheddar = string("Cheddar")
Rye = string("Rye")
Wheat = string("Wheat")
Chili = string("Chili")
Noodle = string("Noodle")
Chicken = string("Chicken")
Turkey = string("Turkey")

Cheese = alt(Cheddar, Swiss)
Bread = alt(Wheat, Rye)
SoupType = alt(Noodle, Chili)
Meat = alt(Chicken, Turkey)

RepeatCheese = sequence(Space, With, Space, Cheese).many

Sandwich = sequence(Meat, Space, On, Space, Bread, RepeatCheese)
Soup = sequence(Meat, Space, SoupType)

Food = alt(Soup, Sandwich) << eof

Food.parse("Chicken Noodle")
Food.parse("Turkey Chili")
Food.parse("Turkey on Rye")
Food.parse("Chicken on Wheat with Cheddar")
Food.parse("Chicken on Wheat with Cheddar with Swiss")