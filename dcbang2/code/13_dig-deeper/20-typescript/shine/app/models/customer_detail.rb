#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class CustomerDetail < ApplicationRecord

  # rest of class...
 
  self.primary_key = 'customer_id'

  def cardholder_id
    self.customer_id
  end

  def serializable_hash(options = nil)
    super.merge({ cardholder_id: cardholder_id })
  end

  def update(params)
    Customer.transaction do
      Customer.find(self.customer_id).update(
        params.permit(:first_name, :last_name, :username, :email))

      Address.find(self.billing_address_id).update(
        address_attributes(params,"billing"))

      Address.find(self.shipping_address_id).update(
        address_attributes(params, "shipping"))
    end
  end

private

  def address_attributes(params, type)
    attributes = {
       street: params["#{type}_street"],
         city: params["#{type}_city"],
        state: State.find_by(code: params["#{type}_state"]),
      zipcode: params["#{type}_zipcode"],
    }
    attributes.delete_if { |_key,value| value.nil? }
  end
end
