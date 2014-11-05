#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'thread'
require 'rinda/ring'

class RingNotify
  def initialize(ts, kind, desc=nil)
    @queue = Queue.new
    pattern = [:name, kind, DRbObject, desc]
    open_stream(ts, pattern)
  end

  def pop
    @queue.pop
  end

  def each
    while tuple = @queue.pop
      yield(tuple)
    end
  end

  private
  def open_stream(ts, pattern)
    @notifier = ts.notify('write', pattern)
    ts.read_all(pattern).each do |tuple|
      @queue.push(tuple)
    end
    @writer = writer_thread
  end

  def writer_thread
    Thread.start do
      begin
        @notifier.each do |event, tuple|
          @queue.push(tuple)
        end
      rescue
        @queue.push(nil)
      end
    end
  end
end