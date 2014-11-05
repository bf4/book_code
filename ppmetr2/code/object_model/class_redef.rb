#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class D
  def x; 'x'; end
end

class D
  def y; 'y'; end
end

obj = D.new
obj.x        # => "x"
obj.y        # => "y"

require_relative '../test/assertions'
assert_equals "x", obj.x
assert_equals "y", obj.y
