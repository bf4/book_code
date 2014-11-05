#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'monitor'
class Rendezvous
  include MonitorMixin
  def initialize
    super
    @arrived_cond = new_cond
    @removed_cond = new_cond
    @box = nil
    @arrived = false
  end

  def send(obj)
    synchronize do
      @removed_cond.wait_while { @arrived }
      @arrived = true
      @box = obj
      @arrived_cond.broadcast
      @removed_cond.wait
    end
  end

  def recv
    synchronize do
      @arrived_cond.wait_until { @arrived }
      @arrived = false
      @removed_cond.broadcast
      return @box
    end
  end
end