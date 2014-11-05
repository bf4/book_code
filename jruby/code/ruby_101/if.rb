#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
cat = 'The cat lives outdoors'

if 2 + 2 == 4
  cat += ' but can be seen indoors'
  dog  = 'The dog lives indoors'
end

dog += ' but can be seen outdoors'

puts cat
# >> The cat lives outdoors but can be seen indoors

puts dog
# >> The dog lives indoors but can be seen outdoors
