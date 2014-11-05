#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
def double(callable_object)
  callable_object.call * 2
end  

l = lambda { return 10 }
double(l) # => 20

require_relative "../test/assertions"
assert_equals 20, double(l)

def another_double
  p = Proc.new { return 10 }
  result = p.call
  return result * 2  # unreachable code!
end

another_double # => 10

assert_equals 10, another_double

p = Proc.new { return 10 }
begin
double(p)     # => LocalJumpError
rescue; end

assert_raises LocalJumpError do
  double(p)
end
  
p = Proc.new { 10 }
double(p)   # => 20

assert_equals 20, double(p)

p = Proc.new {|a, b| [a, b]}
p.arity # => 2

assert_equals 2, p.arity

p = Proc.new {|a, b| [a, b]}
p.call(1, 2, 3)   # => [1, 2]
p.call(1)         # => [1, nil]

assert_equals [1, 2], p.call(1, 2, 3)
assert_equals [1, nil], p.call(1)
