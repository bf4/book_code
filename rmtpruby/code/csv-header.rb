#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "csv"

CSV.foreach("data/shopping-with-header.csv", headers: true) do |record|
  record
  # => #<CSV::Row "Item":"White Bread" "Price":"£1.20" "Shop":"Baker">
  #    , #<CSV::Row "Item":"Whole Milk" "Price":"£0.80" "Shop":"Corner Shop">
  #    , #<CSV::Row "Item":"Gorgonzola" "Price":"£10.20" "Shop":"Cheese Shop">
  #    , #<CSV::Row "Item":"Mature Cheddar" "Price":"£5.20" "Shop":"Cheese Shop">
  #    , #<CSV::Row "Item":"Limburger" "Price":"£6.35" "Shop":"Cheese Shop">
  #    , #<CSV::Row "Item":"Newspaper" "Price":"£1.20" "Shop":"Corner Shop">
  #    , #<CSV::Row "Item":"Ilchester" "Price":"£3.99" "Shop":"Cheese Shop">
end
