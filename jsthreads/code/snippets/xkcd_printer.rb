#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'thread'
require 'net/http'

mutex    = Mutex.new
condvar  = ConditionVariable.new
results  = Array.new

Thread.new do
  10.times do
    response = Net::HTTP.get_response('dynamic.xkcd.com', '/random/comic/')
    random_comic_url = response['Location']

    mutex.synchronize do
      results << random_comic_url
      condvar.signal                     # Signal the ConditionVariable
    end
  end
end

comics_received = 0

until comics_received >= 10
  mutex.synchronize do
    while results.empty?
      condvar.wait(mutex)
    end

    url = results.shift
    puts "You should check out #{url}"
  end

  comics_received += 1
end

