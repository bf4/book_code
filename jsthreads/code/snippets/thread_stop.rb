#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
thread = Thread.new do
  Thread.stop
  puts 'Hello there'
end

# wait for the thread to trigger its stop
nil until thread.status == 'sleep'

thread.wakeup
thread.join

