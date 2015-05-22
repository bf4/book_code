#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'bigdecimal'

def heavy_function
  # this allocates approx. 450k extra objects before returning the result
  Array.new(100000) { BigDecimal(rand(), 3) }.inject(0) { |sum, i| sum + i }
end

# disable GC to compute object allocation statistics
GC.disable
puts "Total Ruby objects before operation: #{ObjectSpace.count_objects[:TOTAL]}"

# open pipe, then close "read" end on child side,
# and "write" end on parent side
read, write = IO.pipe

pid = fork do
  # child may run GC as usual
  GC.enable

  read.close
  result = heavy_function
  # use Marshal.dump to save Ruby objects into the pipe
  Marshal.dump(result, write)

  exit!(0)
end

write.close
result = read.read
# make sure we wait until the child finishes
Process.wait(pid)

# use Marshal.dump to load Ruby objects from pipe
puts Marshal.load(result).inspect

# this number should be not too different from the previous one
puts "Total Ruby objects after operation: #{ObjectSpace.count_objects[:TOTAL]}"
