#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
def BaseClass(name)
  name == "string" ? String : Object
end

class C < BaseClass "string"  # a method that looks like a class
  attr_accessor :an_attribute  # a method that looks like a keyword
end

obj = C.new
obj.an_attribute = 1   # a method that looks like an attribute
