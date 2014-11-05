#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
class BlockingQueue
  def initialize
    @storage = Array.new
  end

  def push(item)
    @storage.push(item)
  end

  def pop
    @storage.shift
  end
end

