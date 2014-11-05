#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class MyClass
  def my_method
    @v = 1
  end
end

obj = MyClass.new
obj.class           # => MyClass

obj.my_method
obj.instance_variables  # => [:@v]

require_relative "../test/assertions"
assert_equals [:@v], obj.instance_variables

obj.methods.grep(/my/)  # => [:my_method]

assert_equals [:my_method], obj.methods.grep(/my/)

String.instance_methods == "abc".methods    # => true
String.methods == "abc".methods             # => false

assert_equals "abc".methods, String.instance_methods
assert_false "abc".methods == String.methods
