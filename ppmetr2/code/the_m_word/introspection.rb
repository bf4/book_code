#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Greeting
  def initialize(text)
    @text = text
  end
  
  def welcome
    @text
  end
end

my_object = Greeting.new("Hello")

my_object.class                             # => Greeting
my_object.class.instance_methods(false)     # => [:welcome]
my_object.instance_variables                # => [:@text]

require_relative '../test/assertions'
assert_equals Greeting, my_object.class
assert_equals [:welcome], my_object.class.instance_methods(false)
assert_equals [:@text], my_object.instance_variables
