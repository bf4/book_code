#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
def get_number_from_somewhere; 2 end

# Ruby:
puts case get_number_from_somewhere
     when 2 then 'twins'
     when 3 then 'triplets'
     when 4 then 'quadruplets'
     else        'unknown'
     end
