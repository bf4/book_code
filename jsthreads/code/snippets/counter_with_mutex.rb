#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
@counter = 0
threads = []
mutex = Mutex.new

5.times do
  threads << Thread.new do     
    mutex.lock
    @counter += 1
    mutex.unlock
  end
end

threads.each(&:join)
puts @counter

