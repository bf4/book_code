#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
def math(a, b)
  yield(a, b)
end

def do_math(a, b, &operation)
  math(a, b, &operation)
end

do_math(2, 3) {|x, y| x * y}  # => 6

require_relative "../test/assertions"
assert_equals 6, do_math(2, 3) {|x, y| x * y}

def my_method(&the_proc)
  the_proc
end

p = my_method {|name| "Hello, #{name}!" }
p.class         # => Proc
p.call("Bill")  # => "Hello, Bill!"

assert_equals Proc, p.class
assert_equals "Hello, Bill!", p.call("Bill")
