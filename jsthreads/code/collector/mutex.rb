#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'thread'

class MutexCollector
  def initialize
    @items = []
    @mutex = Mutex.new
  end

  def <<(item)
    @mutex.synchronize do
      @items << item
    end
  end

  def flush
    @mutex.synchronize do
      return_value = @items.dup
      @items.clear

      return_value
    end
  end
end

