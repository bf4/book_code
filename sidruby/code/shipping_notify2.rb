#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'erb'
class ShippingNotify
  def initialize
    @account = ''
    @customer = ''
    @items = []
    @erb = ERB.new(File.read('shipping_notify.erb')) 
  end
  attr_accessor :account, :customer, :items

  def to_s
    @erb.result(binding)
  end
end
if __FILE__ == $0
  greetings = ShippingNotify.new

  greetings.account = 'm_seki'
  greetings.customer = 'Masatoshi SEKI'
  items = [[1, 'Recollections of erb', Date.new(2008, 6, 22)], 
           [1, 'Great BigTable and my toys', Date.new(2009, 7, 18)],
           [1, 'The last decade of RWiki and lazy me',  Date.today]]
  greetings.items = items

  puts greetings.to_s
end



