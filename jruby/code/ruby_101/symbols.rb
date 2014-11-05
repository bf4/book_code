#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
def exact_same_object?(a, b)
  a.id == b.id
end

# All occurrences of the same Symbol
# share the same instance:

a_class       = :String
another_class = :String

exact_same_object?(a_class, another_class) # => true

# Each string literal creates its own
# separate instance of String:

fake_cheese = "String"
cat_toy     = "String"

exact_same_object?(fake_cheese, cat_toy)   # => false
