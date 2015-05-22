#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "csv"

File.open("data/shopping-with-header.csv") do |input_file|
  File.open("data/shopping-dollars.csv", "w") do |output_file|
    CSV.filter(input_file, output_file, headers: true) do |record|
      dollars = record["Price"].sub(/^£/, "").to_f * 1.58
      record["Price"] = "$%.2f" % dollars
    end
  end
end

puts File.read("data/shopping-dollars.csv")
# >> White Bread,$1.90,Baker
# >> Whole Milk,$1.26,Corner Shop
# >> Gorgonzola,$16.12,Cheese Shop
# >> Mature Cheddar,$8.22,Cheese Shop
# >> Limburger,$10.03,Cheese Shop
# >> Newspaper,$1.90,Corner Shop
# >> Ilchester,$6.30,Cheese Shop
