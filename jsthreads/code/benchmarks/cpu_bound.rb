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

DIGITS = 10_000
ITERATIONS = 24

def calculate_pi(thread_count)
  threads = []

  thread_count.times do
    threads << Thread.new do
      iterations_per_thread = ITERATIONS / thread_count

      iterations_per_thread.times do
        BigMath.PI(DIGITS)
      end
    end
  end

  threads.each(&:join)
end

Benchmark.bm(20) do |bm|
  [1, 2, 3, 4, 6, 8, 12, 24].each do |thread_count|
    bm.report("with #{thread_count} threads") do
      calculate_pi(thread_count)
    end
  end
end

