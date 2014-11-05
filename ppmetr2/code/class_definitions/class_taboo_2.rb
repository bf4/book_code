#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
c = Class.new(Array) do
  def my_method
    'Hello!'
  end
end

MyClass = c

c.name    # => "MyClass"

require_relative '../test/assertions'
assert_equals MyClass, c
assert_equals "MyClass", c.name
