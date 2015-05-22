#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
class Measure

  def self.run(options = {gc: :enable})
    if options[:gc] == :disable
      GC.disable
    elsif options[:gc] == :enable
      # collect memory allocated during library loading
      # and our own code before the measurement
      GC.start
    end

    memory_before = `ps -o rss= -p #{Process.pid}`.to_i/1024
    gc_stat_before = GC.stat
    time = Benchmark.realtime do
      yield
    end
    gc_stat_after = GC.stat
    GC.start if options[:gc] == :enable
    memory_after = `ps -o rss= -p #{Process.pid}`.to_i/1024

    puts({
      RUBY_VERSION => {
        gc: options[:gc],
        time: time.round(2),
        gc_count: gc_stat_after[:count].to_i - gc_stat_before[:count].to_i,
        memory: "%dM" % (memory_after - memory_before)
      }
    }.to_json)
  end

end
