#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class Customer < ApplicationRecord
  has_many :customers_shipping_address

  # Helper to get just the primary shipping address
  def primary_shipping_address
    self.customers_shipping_address.find_by(primary: true).address
  end
  has_one :customers_billing_address
  has_one :billing_address, through: :customers_billing_address,
                             source: :address
end
