#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'drb/drb'
require 'rinda/rinda'
require 'rinda/tuplespace'
class MultipleNotify
  def initialize(ts, event, ary)
    @queue = Queue.new
    @entry = []
    ary.each do |pattern|
      make_listener(ts, event, pattern)
    end
  end
  def pop
    @queue.pop
  end
  def make_listener(ts, event, pattern)
    entry = ts.notify(event, pattern)
    @entry.push(entry)
    Thread.new do 
      entry.each do |ev|
        @queue.push(ev)
      end
    end
  end
end