#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'benchmark'
def fib(n)
  n < 2 ? n : fib(n - 2) + fib(n - 1)
end
def task(n)
  puts "fib(#{n}) = #{fib(n)}"
end

puts Benchmark.measure{
  [30, 30, 30].each{|x| task x}
}
