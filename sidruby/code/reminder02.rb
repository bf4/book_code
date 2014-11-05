#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'monitor'

class Reminder
  include MonitorMixin
  def initialize
    super
    @item = {}
    @serial = 0
  end

  def [](key)
    @item[key]
  end

  def add(str)
    synchronize do
      @serial += 1
      @item[@serial] = str
      @serial
    end
  end

  def delete(key)
    synchronize do
      @item.delete(key)
    end
  end

  def to_a
    synchronize do
      @item.keys.sort.collect do |k|
        [k, @item[k]]
      end
    end
  end
end

if __FILE__ == $0
  require 'drb/drb'
  front = Reminder.new
  DRb.start_service('druby://localhost:12345', front)
  puts DRb.uri
  DRb.thread.join
end