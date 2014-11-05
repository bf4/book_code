#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'benchmark'
require 'atomic'

iterations = 10_000
num_threads = 100

Benchmark.bm(30) do |x|
  x.report('locking <> heavy contention') do
    @counter = 0
    @mutex = Mutex.new
    
    num_threads.times.map do
      Thread.new do
        iterations.times do
          @mutex.synchronize do
            current_value = @counter
            new_value = current_value + 1
            @counter = new_value
          end
        end
      end
    end.each(&:join)
  end
  
  x.report('lockless <> heavy contention') do
    @counter = Atomic.new(0)
    
    num_threads.times.map do
      Thread.new do
        iterations.times do
          @counter.update { |current_value| 
            current_value + 1 
          }
        end
      end
    end.each(&:join)
  end
end
