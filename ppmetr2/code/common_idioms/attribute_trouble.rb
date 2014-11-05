#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class MyClass
  attr_accessor :my_attribute
  
  def set_attribute(n)
    my_attribute = n
  end
end

obj = MyClass.new
obj.set_attribute 10
obj.my_attribute          # => nil

require_relative '../test/assertions'
assert_equals nil, obj.my_attribute

class MyClass
  def set_attribute(n)
    self.my_attribute = n
  end
end

obj.set_attribute 10
obj.my_attribute          # => 10

assert_equals 10, obj.my_attribute

class MyClass
  private :my_attribute
end

obj.set_attribute 11      # No error!
obj.send :my_attribute    # => 11

assert_equals 11, obj.send(:my_attribute)
