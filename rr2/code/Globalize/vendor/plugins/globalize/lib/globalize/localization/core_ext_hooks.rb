#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# Hook up core extenstions (need to define them as main level, hence 
# the :: prefix)
class ::String # :nodoc: 
  include Globalize::CoreExtensions::String
end

class ::Symbol # :nodoc:  
  include Globalize::CoreExtensions::Symbol
end

class ::Object # :nodoc:  
  include Globalize::CoreExtensions::Object
end

class ::Fixnum # :nodoc:
  include Globalize::CoreExtensions::Integer 
end

class ::Bignum # :nodoc:
  include Globalize::CoreExtensions::Integer
end

class ::Float # :nodoc:
  include Globalize::CoreExtensions::Float  
end

class ::Time # :nodoc:
  include Globalize::CoreExtensions::Time
end

class ::Date # :nodoc:
  include Globalize::CoreExtensions::Date
end
