#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'atomic'

@counter = Atomic.new(0)

loop do
  current_value = @counter.value
  new_value = current_value + 1

  if @counter.compare_and_set(current_value, new_value)
    break
  end
end
