#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'benchmark'
require 'open-uri'

URL = 'http://www.nytimes.com/'
ITERATIONS = 30

def fetch_url(thread_count)
  threads = []

  thread_count.times do
    threads << Thread.new do
      fetches_per_thread = ITERATIONS / thread_count

      fetches_per_thread.times do
        open(URL)
      end
    end
  end

  threads.each(&:join)
end

Benchmark.bm(20) do |bm|
  [1, 2, 3, 5, 6, 10, 15, 30].each do |thread_count|
    bm.report("with #{thread_count} threads") do
      fetch_url(thread_count)
    end
  end
end

