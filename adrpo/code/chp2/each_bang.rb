#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
class Thing; end
list = Array.new(1000) { Thing.new }
puts ObjectSpace.each_object(Thing).count  # 1000 objects

list.each do |item|
  GC.start
  puts ObjectSpace.each_object(Thing).count  # same count as before
  # do something with the item
end

list = nil
GC.start
puts ObjectSpace.each_object(Thing).count   # everything has been deallocated

list = Array.new(1000) { Thing.new }
puts ObjectSpace.each_object(Thing).count  # allocate 1000 objects again

while list.count > 0
  GC.start    # this will garbage collect item from previous iteration
  puts ObjectSpace.each_object(Thing).count  # watch the counter decreasing

  item = list.shift
  # do something with the item
end
