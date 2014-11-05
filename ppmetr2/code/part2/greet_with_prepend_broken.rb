#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class MyClass
  def greet
    "hello"
  end
end

module EnthusiasticGreetings
  def greet
    "Hey, #{super}!"
  end
end
  
class MyClass
  include EnthusiasticGreetings
end

MyClass.ancestors[0..2]  # => [MyClass, EnthusiasticGreetings, Object]
MyClass.new.greet        # => "hello"

require_relative '../test/assertions'
assert_equals [MyClass, EnthusiasticGreetings, Object], MyClass.ancestors[0..2]
assert_equals "hello", MyClass.new.greet
