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

mutex = Mutex.new
@results = []

10.times.map do
  Thread.new do
    mutex.synchronize do
      response = Net::HTTP.get_response('dynamic.xkcd.com', '/random/comic/')
      random_comic_url = response['Location']

      @results << random_comic_url
    end
  end
end.each(&:join)

puts @results

