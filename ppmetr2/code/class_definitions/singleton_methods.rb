#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
str = "just a regular string"

def str.title?
  self.upcase == self
end

str.title?                      # => false
str.methods.grep(/title?/)      # => [:title?]
str.singleton_methods           # => [:title?]

require_relative '../test/assertions'
assert_false str.title?
assert_equals [:title?], str.methods.grep(/title?/)
assert_equals [:title?], str.singleton_methods
