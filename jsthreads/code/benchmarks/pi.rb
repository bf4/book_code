#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'benchmark'

require 'bigdecimal'
require 'bigdecimal/math'

digits = 1_000
iterations = 100

num_threads = 5
iterations_per_thread = iterations / num_threads

Benchmark.bm(15) do |x|
  x.report('single-threaded') do
    iterations.times do
      BigMath.PI(digits)
    end
  end

  x.report('multi-threaded') do
    num_threads.times.map do
      Thread.new do
        iterations_per_thread.times do
          BigMath.PI(digits)
        end
      end
    end.each(&:join)
  end
end

