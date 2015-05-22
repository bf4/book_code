#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
puts "memory usage at start %dM" %
  (`ps -o rss= -p #{Process.pid}`.to_i/1024)

str = "x" * 1024 * 1024 * 10  # 10MB

puts "memory usage after large string creation %dM" %
  (`ps -o rss= -p #{Process.pid}`.to_i/1024)

str = nil
GC.start(full_mark: true, immediate_sweep: true)

puts "memory usage after string is finalized %dM" %
  (`ps -o rss= -p #{Process.pid}`.to_i/1024)
