#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'thread'

class BlockingQueue
  def initialize
    @storage = Array.new
    @mutex = Mutex.new
    @condvar = ConditionVariable.new
  end

  def push(item)
    @mutex.synchronize do
      @storage.push(item)
      @condvar.signal
    end
  end

  def pop
    @mutex.synchronize do
      while @storage.empty?
        @condvar.wait(@mutex)
      end

      @storage.shift
    end
  end
end

