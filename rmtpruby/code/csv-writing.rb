#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "csv"

CSV.open("data/writing.csv", "w") do |csv|
  csv << ["field one", "field two", "field three"]
  csv << ["another field one", "another field two", "field three, again"]
end

puts File.read("data/writing.csv")
# >> field one,field two,field three
# >> another field one,another field two,"field three, again"
