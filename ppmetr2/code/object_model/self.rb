#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class MyClass
  def testing_self
    @var = 10     # An instance variable of self
    my_method()   # Same as self.my_method()
    self
  end
  
  def my_method
    @var = @var + 1
  end
end

obj = MyClass.new
obj.testing_self  # => #<MyClass:0x007f93ab08a728 @var=11>
