#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class Reminder
  def initialize
    @item = {}
    @serial = 0
  end
  def [](key)
    @item[key]
  end
  def add(str)
    @serial += 1
    @item[@serial] = str
    @serial
  end
  def delete(key)
    @item.delete(key)
  end
  def to_a
    @item.keys.sort.collect do |k|
      [k, @item[k]]
    end
  end
end
