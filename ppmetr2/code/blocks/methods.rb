#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class MyClass
  def initialize(value)
    @x = value
  end
  def my_method
    @x
  end
end

object = MyClass.new(1)
m = object.method :my_method
m.call                            # => 1

require_relative "../test/assertions"
assert_equals 1, m.call
