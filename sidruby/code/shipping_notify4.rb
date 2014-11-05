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
  end
  attr_accessor :account, :customer, :items

  def shipping_status(shipped)
    if shipped == Date.today
      'Just shipped'
    elsif shipped < Date.today
      'Shipped ' + shipped.strftime("%B %d, %Y")
    else
      'NA'
    end
  end
  extend ERB::DefMethod
  def_erb_method('to_s', 'shipping_notify3.erb')
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





