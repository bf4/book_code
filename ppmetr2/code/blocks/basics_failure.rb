#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
def a_method(a, b)
  a + yield(a, b)
end

a_method(1, 2) {|x, y| (x + y) * 3 }  # => 10

require_relative '../test/assertions'
assert_equals 10, a_method(1, 2) {|x, y| (x + y) * 3 }

def a_method
  return yield if block_given?
  'no block'
end

a_method                          # => "no block"
a_method { "here's a block!" }    # => "here's a block!"

assert_equals "no block", a_method
assert_equals "here's a block!", a_method {"here's a block!"}
