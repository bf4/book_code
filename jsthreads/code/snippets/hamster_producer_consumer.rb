#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'hamster/queue'
require 'atomic'

@queue_wrapper = Atomic.new(Hamster::Queue.new)

30.times do
  @queue_wrapper.update { |queue|
    queue.enqueue(rand(100))
  }
end

consumers = []

3.times do
  consumers << Thread.new do
    10.times do
      number = nil

      @queue_wrapper.update { |queue|
        number = queue.head
        queue.dequeue
      }

      puts "The cubed root of #{number} is #{Math.cbrt(number)}"
    end
  end
end

consumers.each(&:join)

