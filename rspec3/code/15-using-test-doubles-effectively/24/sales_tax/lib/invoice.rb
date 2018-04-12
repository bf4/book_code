#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'my_app'
require 'sales_tax'

class Invoice
  def initialize(address, items, sales_tax: SalesTax.new)
    @address = address
    @items = items
    @sales_tax = sales_tax
  end

  def calculate_total
    subtotal = @items.map(&:cost).inject(0, :+)
    taxes = subtotal * tax_rate
    subtotal + taxes
  end

private

  def tax_rate
    @sales_tax.rate_for(@address.zip)
  end
end
