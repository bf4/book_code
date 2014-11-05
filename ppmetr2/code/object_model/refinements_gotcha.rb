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
    "original my_method()"
  end
  
  def another_method
    my_method
  end
end

module MyClassRefinement
  refine MyClass do
    def my_method
      "refined my_method()"
    end
  end
end

using MyClassRefinement
MyClass.new.my_method       # =>  "refined my_method()"
MyClass.new.another_method  # =>  "original my_method()"

require_relative '../test/assertions'
assert_equals "refined my_method()", MyClass.new.my_method
assert_equals "original my_method()", MyClass.new.another_method
