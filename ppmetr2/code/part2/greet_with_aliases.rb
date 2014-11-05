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

class MyClass
  include Greetings

  def greet_with_enthusiasm
    "Hey, #{greet_without_enthusiasm}!"
  end
  
  alias_method :greet_without_enthusiasm, :greet
  alias_method :greet, :greet_with_enthusiasm
end

MyClass.new.greet  # => "Hey, hello!"

MyClass.new.greet_without_enthusiasm  # => "hello"

require_relative '../test/assertions'
assert_equals "hello", MyClass.new.greet_without_enthusiasm
assert_equals "Hey, hello!", MyClass.new.greet_with_enthusiasm
assert_equals "Hey, hello!", MyClass.new.greet
