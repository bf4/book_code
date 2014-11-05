#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
def assert(condition)
  raise "Error" unless condition
  puts "Assertion OK"
end

def assert_completes(condition)
  assert condition
end

def assert_false(condition)
  assert !condition
end

def assert_equals(x, y)
  raise "Expected #{x}, got #{y}" unless x == y
  puts "Assertion OK: I expected #{x} and I got it"
end

def assert_matches(regexp, x)
  raise "Expected #{x} to match #{regexp}" unless x.to_s =~ Regexp.new(regexp)
  puts "Assertion OK: I expected #{x} to match #{regexp} and it does"
end

def assert_raises(klass)
  yield
  raise "Expected a #{klass}, didn't get it"
rescue klass
end

