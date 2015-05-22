#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'benchmark'

def performance_benchmark(name, &block)
  # 31 runs, we'll discard the first result
  (0..30).each do |i|
    # force GC in parent process to make sure we reclaim
    # any memory taken by forking in previous run
    GC.start

    # fork to isolate our run
    pid = fork do
      # again run GC to reduce effects of forking
      GC.start
      # disable GC if you want to see the raw performance of your code
      GC.disable if ENV["RUBY_DISABLE_GC"]

      # because we are in a forked process, we need to store
      # results in some shared space. local file is the simplest way to do that
      benchmark_results = File.open("benchmark_results_#{name}", "a")

      elapsed_time = Benchmark::realtime do
        yield
      end

      # do not count the first run
      if i > 0
        # we use system clock for measurements,
        # so microsecond is the last significant figure
        benchmark_results.puts elapsed_time.round(6)
      end
      benchmark_results.close

      GC.enable if ENV["RUBY_DISABLE_GC"]
    end
    Process::waitpid pid
  end

  measurements = File.readlines("benchmark_results_#{name}").map do |value|
    value.to_f
  end
  File.delete("benchmark_results_#{name}")

  average = measurements.inject(0) { |sum, x| sum + x }.to_f / measurements.size
  stddev = Math.sqrt(
    measurements.inject(0){ |sum, x| sum + (x - average)**2 }.to_f /
      (measurements.size - 1)
  )

  # return both average and standard deviation, this time in millisecond precision
  # for all practical purposes that should be enough
  [name, average.round(3), stddev.round(3)]
end
