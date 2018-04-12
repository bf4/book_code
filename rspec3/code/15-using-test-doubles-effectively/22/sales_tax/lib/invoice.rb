#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'my_app'

class Invoice
  def initialize(address, items, tax_client: MyApp.tax_client)
    @address = address
    @items = items
    @tax_client = tax_client
  end

  def calculate_total
    subtotal = @items.map(&:cost).inject(0, :+)
    taxes = subtotal * tax_rate
    subtotal + taxes
  end

private

  def tax_rate
    @tax_client.rates_for_location(@address.zip).combined_rate
  end
end
