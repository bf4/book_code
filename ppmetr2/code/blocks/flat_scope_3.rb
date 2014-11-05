#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
my_var = "Success"

MyClass = Class.new do
  "#{my_var} in the class definition"

  define_method :my_method do
    "#{my_var} in the method"
  end
end

MyClass.new.my_method

require_relative "../test/assertions"
assert_equals "Success in the method", MyClass.new.my_method
