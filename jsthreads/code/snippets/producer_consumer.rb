#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'thread'

queue = Queue.new

producer = Thread.new do
  10.times do
    queue.push(Time.now.to_i)
    sleep 1
  end
end

consumers = []

3.times do
  consumers << Thread.new do
    loop do
      unix_timestamp = queue.pop
      formatted_timestamp = unix_timestamp.to_s.reverse.
                            gsub(/(\d\d\d)/, '\1,').reverse

      puts "It's been #{formatted_timestamp} seconds since the epoch!"
    end
  end
end

producer.join

