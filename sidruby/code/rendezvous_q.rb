#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'thread'
class Rendezvous
  def initialize
    super
    @send_queue = SizedQueue.new(1)
    @recv_queue = SizedQueue.new(1)
  end
  def send(obj)
    @send_queue.enq(obj)
    @recv_queue.deq
  end

  def recv
    @send_queue.deq
  ensure
    @recv_queue.enq(nil)
  end
end