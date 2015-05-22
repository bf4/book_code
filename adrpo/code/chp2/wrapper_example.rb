#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'wrapper'
require 'csv'

measure do
  data = CSV.open("data.csv")
  output = data.readlines.map do |line|
    line.map { |col| col.downcase.gsub(/\b('?[a-z])/) { $1.capitalize } }
  end
  File.open("output.csv", "w+") { |f| f.write output.join("\n") }
end
