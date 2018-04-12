#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class CustomerDetail < ApplicationRecord
  self.primary_key = 'customer_id'

  def cardholder_id
    self.customer_id
  end

  def serializable_hash(options = nil)
    super.merge({ cardholder_id: cardholder_id })
  end
end
