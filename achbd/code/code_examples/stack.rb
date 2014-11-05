#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class StackUnderflowError < RuntimeError
end

class StackOverflowError < RuntimeError
end

class Stack
  
  def initialize
    @items = []
  end
  
  def size
    @items.size
  end
  
  def push object
    raise StackOverflowError if @items.length == 10
    @items.push object
  end
  
  def pop
    raise StackUnderflowError if @items.empty?
    @items.delete @items.last
  end
  
  def peek
    raise StackUnderflowError if @items.empty?
    @items.last
  end
  
  def empty?
    @items.empty?
  end

  def full?
    @items.length == 10
  end
  
end
