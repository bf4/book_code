#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module MyModule
  def my_method
    42
  end
end

unbound = MyModule.instance_method(:my_method)
unbound.class              # => UnboundMethod

String.class_eval do
  define_method :another_method, unbound
end

"abc".another_method  # => 42

require_relative "../test/assertions"
assert_equals UnboundMethod, unbound.class
assert_equals 42, "abc".another_method
