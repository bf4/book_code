#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require 'atomic'

class NaiveAtomicCollector
  def initialize
    @items = Atomic.new(Array.new)
  end

  def <<(item)
    @items.update do |list|
      new_list = list.dup
      new_list << item
    end
  end

  def flush
    return_value = nil

    @items.update do |list|
      return_value = list.dup
      []
    end

    return_value
  end
end

class LinkedAtomicCollector
  Node = Struct.new(:value, :successsor)

  def initialize
    dummy_node = Node.new(nil, nil)
    @head = Atomic.new(dummy_node)
  end
  
  def <<(item)
    @head.update do |previous_head|
      Node.new(item, previous_head)
    end
  end

  
  def flush
    detached_head = nil
    @head.update do |current_head|
      detached_head = current_head.successsor

      current_head.successor = nil # this isn't safe...
      current_head
    end

    return_value = []
    node = detached_head
    while node != nil do
      return_value << node.value
      node = node.successor
    end

    return_value
  end
end

