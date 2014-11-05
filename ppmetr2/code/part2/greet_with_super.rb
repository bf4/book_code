#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Greetings
  def greet
    "hello"
  end
end

class MyClass
  include Greetings
end

MyClass.new.greet  # => "hello"

module EnthusiasticGreetings
  include Greetings
  
  def greet
    "Hey, #{super}!"
  end
end
  
class MyClass
  include EnthusiasticGreetings
end

MyClass.ancestors[0..2]  # => [MyClass, EnthusiasticGreetings, Greetings]
MyClass.new.greet        # => "Hey, hello!"

require_relative '../test/assertions'
assert_equals "Hey, hello!", MyClass.new.greet
assert_equals [MyClass, EnthusiasticGreetings, Greetings], MyClass.ancestors[0..2]
