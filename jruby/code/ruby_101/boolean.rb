#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
def truthy?(value)
  if value then true else false end
end

truthy? true  # => true
truthy? false # => false
truthy? nil   # => false

truthy? ""    # => true
truthy? []    # => true
truthy? 0     # => true
