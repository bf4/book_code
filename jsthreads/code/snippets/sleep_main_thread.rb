#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
thread = Thread.new do
  # do the important work
end

# The main thread sleeps to prevent it from finishing execution. 
# If it were allowed to run, it would simply exit, killing the other 
# thread and preventing it from doing its important work.
sleep

