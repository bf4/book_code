#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
pattern = /([^,]+), ([A-Z]{2}) (\d{5})/

if "Portland, OR 97201" =~ pattern
  puts 'Yay, it matches!'
  puts 'City  ' + $1
  puts 'State ' + $2
  puts 'ZIP   ' + $3
end
