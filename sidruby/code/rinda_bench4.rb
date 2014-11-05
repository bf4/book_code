#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'benchmark'
def task(n)
  sleep(n * 0.1)
end
puts Benchmark.measure{
  [30,30,30].map{|x| Thread.new{task x}}.map{|y| y.join}
}
