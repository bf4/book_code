#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class ShippingNotify
  def initialize
    @account = ''
    @customer = ''
    @items = []
  end
  attr_accessor :account, :customer, :items

  def to_s
    str = <<EOS
Dear #{customer}

This note is just to let you know that we've shipped
some items that you ordered.

-----------------------------------------
Qty Item
      Shipping Status
-----------------------------------------
EOS
    items.each do |qty, item, shipped|
      if shipped == Date.today
        status = 'Just shipped'
      elsif shipped < Date.today
        status = 'Shipped ' + shipped.strftime("%B %d, %Y")
      else
        status = 'NA'
      end
      str << "#{qty} #{item}\n"
      str << "       - #{status}\n"
    end
    str << <<EOS
-----------------------------------------

You can print the receipt and check the status of this
order (and any of your other orders) online by visiting
your account at http://www.druby.org/#{account}

http://www.druby.org
EOS
    return str
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



