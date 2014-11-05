#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
list = [1, 2, 3, 4]

list.each { |n| puts n }

list.each do |n|
  puts n
end

def yield_thrice(value)
  yield value + 10
  yield value + 20
  yield value + 30
end

def call_thrice(value, &block)
  block.call value + 10
  block.call value + 20
  block.call value + 30
end

# Both of these will print the numbers 110, 120, and 130:
yield_thrice(100) { |n| puts n }
call_thrice(100)  { |n| puts n }
