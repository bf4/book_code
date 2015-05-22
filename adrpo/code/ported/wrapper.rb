#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require "json"
require "benchmark"

def measure(&block)
  GC.disable if ARGV[1] == "--no-gc"

  gc_stat_before = GC.stat
  time = Benchmark.realtime do
    yield
  end
  gc_stat_after = GC.stat

  puts({
    RUBY_VERSION => {
      time: time.round(2),
      gc: ARGV[1] != "--no-gc",
      gc_count: gc_stat_after[:count] - gc_stat_before[:count]
    }
  }.to_json)
end

require ARGV[0]
