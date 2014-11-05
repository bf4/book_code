#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class Person
  def self.with_address_and_phone_number(addr, ph)
    p = Person.new
    p.add_address(addr)
    p.add_phone_number(ph)
    p
  end
end

# The following can appear between "class Person ..." and "end",
# or it can stand alone, outside the class definition.
#
def Person.with_address_and_phone_number(addr, ph)
  # ...
end
