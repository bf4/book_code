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

MyClass.new.greet  # => "hello"

module EnthusiasticGreetings
  def greet
    "Hey, #{super}!"
  end
end
  
class MyClass
  prepend EnthusiasticGreetings
end

MyClass.ancestors[0..2]  # => [EnthusiasticGreetings, MyClass, Object]
MyClass.new.greet        # => "Hey, hello!"

require_relative '../test/assertions'
assert_equals [EnthusiasticGreetings, MyClass, Object], MyClass.ancestors[0..2]
assert_equals "Hey, hello!", MyClass.new.greet
